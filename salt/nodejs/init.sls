
include:
  - apt.transport-https

nodejs:
  pkgrepo.managed:
    - humanname: nodejs
    - name: deb https://deb.nodesource.com/node_13.x {{ grains.oscodename }} main
    - key_url: salt://nodejs/nodesource.gpg.key
    - clean_file: True
    - require_in:
      - pkg: nodejs
    - require:
      - pkg: apt-transport-https
  pkg.installed:
    - name: nodejs