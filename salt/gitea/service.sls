{% from "gitea/map.jinja" import gitea with context %}

/etc/systemd/system/gitea.service:
  file.managed:
    - source: salt://gitea/gitea.service
    - user: root
    - group: root
    - mode: 644

gitea:
  service.running:
    - enable: True
    - full_restart: True
    - watch:
      - file: /usr/local/bin/gitea
      - file: /etc/gitea/app.ini