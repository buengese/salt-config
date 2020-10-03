base:
    '*':
      - timezone
      - ssh
      - users
      - apt
      - unattended-upgrades
      - certs
    'unifi*'
      - unifi
      - nginx
    'thorium*'
      - blacklist