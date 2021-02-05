#
# Reverse proxy
#

include: 
  - nginx.install

{% set domain = pillar['reverse_proxy']['domain'] %}
/etc/nginx/sites-available/{{ domain }}:
  file.managed:
    - source: salt://nginx/files/reverse-proxy.conf.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx
    - watch_in:
      - cmd: nginx-configtest

/etc/nginx/sites-enabled/{{ domain }}:
  file.symlink:
    - target: /etc/nginx/sites-available/{{ domain }}
    - require:
      - file: /etc/nginx/sites-available/{{ domain }}
