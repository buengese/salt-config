base:
    '*':
      - globals
      - keys
    'salt*':
      - nodes.salt
    'deb*':
      - nodes.thorium
      - nodes.unifi
