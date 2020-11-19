base:
    '*':
    # Base states first
      - timezone
      - ssh
      - users
      - bash

    # Debian specific apt - certs to be moved
    'os_family:Debian':
      - apt
      - unattended-upgrades
      - certs
      - tmux
      - screen

    # Node specific stuff
    # Unifi controller
    'unifi*':
      - unifi
      - nginx.reverse-proxy

    # TheLounge IRC client
    'irc*':
      - nodejs
      - thelounge
      - nginx.reverse-proxy

    # DNS server for secure lan
    'dns-secure*':
      - unbound

    # Gitea instance
    'git*':
      - gitea

    # Salt-SSH - no grain targeting
    'thorium*':
      - timezone
      - ssh
      - users
      - bash
      - blacklist
