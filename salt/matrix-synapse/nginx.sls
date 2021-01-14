{% from "matrix-synapse/map.jinja" import matrix with context %}

include: 
  - nginx.base

/etc/nginx/sites-available/{{ matrix.host }}.conf:
  file.managed:
    - source: salt://matrix-synapse/matrix-proxy.conf.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx
    - watch_in:
      - cmd: nginx-configtest

/etc/nginx/sites-enabled/{{ matrix.host }}.conf:
  file.symlink:
    - target: /etc/nginx/sites-available/{{ matrix.host }}.conf
    - require:
      - file: /etc/nginx/sites-available/{{ matrix.host }}.conf
