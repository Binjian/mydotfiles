"""Hostname-only tabs, retaining SSH destinations when remote tmux changes titles."""
import os
import re
import socket
from urllib.parse import urlsplit

from kitty.fast_data_types import get_boss
from kitty.tab_bar import draw_tab_with_powerline

_LOCAL_HOST = socket.gethostname().split('.')[0]
_REMOTE_HOSTS = {}


def ssh_destination(argv):
    """Find the destination without mistaking SSH option values for hosts."""
    start = next((i for i, arg in enumerate(argv) if os.path.basename(arg) == 'ssh'), None)
    if start is None:
        return None
    args = iter(argv[start + 1:])
    for arg in args:
        if arg == '--':
            arg = next(args, '')
        elif arg.startswith('-'):
            # These OpenSSH options take arguments, possibly attached.
            if any(c in 'BbcDEeFIiJLlmOopQRSWw' for c in arg[1:]):
                if len(arg) == 2:
                    next(args, None)
            continue
        if arg:
            if arg.startswith('ssh://'):
                return urlsplit(arg).hostname
            return arg.rsplit('@', 1)[-1].strip('[]')
    return None


def title_hostname(title):
    match = re.search(r'(?:^|\s)[^\s@]+@([^\s:]+)', title)
    if match:
        return match.group(1)
    if ' - ' in title:
        host = title.rsplit(' - ', 1)[-1].strip()
        if re.fullmatch(r'[\w.-]+', host):
            return host
    return None


def hostname_for_window(window, title):
    destinations = []
    if window is not None:
        child = window.child
        commands = [child.foreground_cmdline, child.cmdline]
        kitten_command = getattr(window, "ssh_kitten_cmdline", None)
        if kitten_command:
            commands.append(kitten_command())
        commands.extend(p.get('cmdline', []) for p in child.foreground_processes)
        for command in commands:
            destination = ssh_destination(command)
            if destination:
                destinations.append(destination)
    reported = title_hostname(title)
    if destinations:
        # Retain the real hostname if tmux replaces it with a command/session title.
        key = (getattr(window, "id", id(window)), destinations[0])
        if reported and reported != _LOCAL_HOST:
            _REMOTE_HOSTS[key] = reported
        return _REMOTE_HOSTS.get(key, destinations[0])
    window_id = getattr(window, "id", id(window))
    for key in list(_REMOTE_HOSTS):
        if key[0] == window_id:
            del _REMOTE_HOSTS[key]
    return reported or _LOCAL_HOST


def draw_tab(draw_data, screen, tab, before, max_tab_length, index, is_last, extra_data):
    real_tab = get_boss().tab_for_id(tab.tab_id)
    window = real_tab.active_window if real_tab else None
    host = hostname_for_window(window, tab.title)
    return draw_tab_with_powerline(
        draw_data, screen, tab._replace(title=host), before,
        max_tab_length, index, is_last, extra_data,
    )
