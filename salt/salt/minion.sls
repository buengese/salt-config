{% from "salt/map.jinja" import salt with context %}
# salt minion config
 
salt-minion:
    pkg.installed: []
    service.running:
        - enable: True
        - running: True
        - require:
            - pkg: salt-minion 

/etc/salt/master:
    file.managed:
        - user: root
        - group: root
        - mode: 644
        - source: salt://salt/minion.j2
        - template: jinja
