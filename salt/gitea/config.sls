{% from "gitea/map.jinja" import gitea with context %}

/etc/gitea/app.ini:
  file.managed:
    - source: salt://gitea/app.ini.j2
    - template: jinja
    - user: git
    - group: git
    - mode: 640