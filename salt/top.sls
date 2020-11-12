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

    'dns-secure*':
      - unbound

    # Salt-SSH - no grain targeting
    'thorium*':
      - blacklist
