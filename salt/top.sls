base:
    '*':
      - timezone
      - ssh
      - users
      - apt
      - unattended-upgrades
      - certs
    'unifi*':
      - unifi
      - nginx.reverse-proxy
    'irc*':
      - nodejs
      - thelounge
      - nginx.reverse-proxy
    'thorium*':
      - blacklist
