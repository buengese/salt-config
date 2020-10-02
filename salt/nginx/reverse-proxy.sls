#
# Reverse proxy
#

include: nginx.base

{% set node_config = salt['pillar.get']('node') %}
{% set domain = node_config.get('reverse_proxy:domain') %}
/etc/nginx/sites-available/{{ domain }}:
  file.managed:
    - source: salt://nginx/reverse_proxy.tmpl
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/{{ domain }}:
  file.symlink:
    - target: /etc/nginx/sites-available/{{ domain }}
    - require:
      - file: /etc/nginx/sites-available/{{ domain }}
    - watch_in:
      - cmd: nginx-configtest