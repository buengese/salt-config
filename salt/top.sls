base:
    '*':
    # Base states first
      - timezone
      - ssh
      - users
      - bash

    # Debian specific apt - certs to be moved
    'os_family:Debian':
      - match: grain
      - apt
      - unattended-upgrades
      - certs
      - tmux
      - screen
      - salt.minion

    # Node specific stuff
    'iridium.bngs.io':
      - salt.master
    
    'salt.bmn.net':
      - salt.master

    # Matrix Server
    'radon.rc8.eu':
      - matrix-synapse

    # Static web content 
    'francium.bngs.io':
      - letsencrypt
      - nginx.static
 
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

