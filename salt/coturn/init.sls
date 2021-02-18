#
# Coturn STUN/TURN server
#
coturn:
  pkg.installed: []
  service.running:
      - enable: True
      - require:
        - pkg: coturn

/etc/turnserver.conf:
   file.managed:
     - source: salt://coturn/files/turnserver.conf.j2
     - template: jinja
     - user: root
     - group: root
     - mode: 644
     - require:
       - pkg: coturn
     - watch_in:
       - service: coturn
