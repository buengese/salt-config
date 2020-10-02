#
# Unifi controller
#

gpg:
  pkg.installed: []

unifi-repo:
  pkgrepo.managed:
    - humanname: Unifi-Repo
    - name: deb https://www.ui.com/downloads/unifi/debian stable ubiquiti
    - file: /etc/apt/sources.list.d/100-ubnt-unifi.list
    - keyid: 06E85760C0A52C50
    - keyserver: keyserver.ubuntu.com
    - refresh: True
    - require:
      - pkg: gpg

mongodb:
  pkg.installed:
    - pkgs:
      - mongodb-server: 1:3.6.3-0ubuntu1.1
      - mongodb-clients: 1:3.6.3-0ubuntu1.1

java:
  pkg.installed:
    - name: openjdk-8-jre-headless
    - hold: True

unifi:
  pkg.installed:
    - name: unifi
    - require:
      - pkg: mongodb
      - pkg: java
  service.running:
    - enable: True
