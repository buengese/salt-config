{% from "gitea/map.jinja" import gitea with context %}

git:
  pkg.installed: []
  user.present:
    - system: True 
    - home: /home/git
    - shell: /usr/sbin/nologin
    - require:
        - group: git
  group.present:
    - system: True

{% set db = gitea.database.name ~ '.*' %}
mysql:
  mysql_user.present:
    - name: {{ gitea.database.user }}
    - password: {{ gitea.database.password }}
  mysql_database.present:
    - name: {{ gitea.database.name }}
  mysql_grants.present:
    - database: {{ db }}
    - grant: ALL
    - user: {{ gitea.database.user }}

/usr/local/bin/gitea:
  file.managed:
    - source: https://dl.gitea.io/gitea/{{ gitea.version }}/gitea-{{ gitea.version }}-linux-amd64
    - source_hash: https://dl.gitea.io/gitea/{{ gitea.version }}/gitea-{{ gitea.version }}-linux-amd64.sha256
    - require:
      - git

low_ports:
  cmd.run:
    - name: setcap CAP_NET_BIND_SERVICE=+eip /usr/local/bin/gitea

/var/lib/gitea/custom:
  file.directory:
    - user: git
    - group: git
    - dir_mode: 750

/var/lib/gitea/data:
  file.directory:
    - user: git
    - group: git
    - dir_mode: 750

/var/lib/gitea/log:
  file.directory:
    - user: git
    - group: git
    - dir_mode: 750

/etc/gitea:
  file.directory:
    - user: root
    - group: git
    - dir_mode: 770