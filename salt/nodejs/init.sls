
include:
  - apt.transport-https

nodejs:
  pkgrepo.managed:
    - humanname: nodejs
    - name: deb https://deb.nodesource.com/node_12.x {{ grains.oscodename }} main
    - key_url: salt://nodejs/nodesource.gpg.key
    - file: /etc/apt/sources.list.d/nodesource.list
    - clean_file: True
    - require_in:
      - pkg: nodejs
    - require:
      - pkg: apt-transport-https
  pkg.installed:
    - name: nodejs