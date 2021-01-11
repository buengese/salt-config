{% from "salt/map.jinja" import salt with context %}
 # salt master config
 
salt-master:
    pkg.installed: []
    service.running:
        - enable: True
        - running: True
        - require:
            - pkg: salt-master

git -C /srv/salt pull -q:
    cron.present:
        - user: root
        - minute: '"/5'
        
/etc/salt/master:
    file.managed:
        - user: root
        - group: root
        - mode: 644
        - source: salt://salt/master.j2
        - template: jinja
