{% from "nginx/map.jinja" import nginx with context %}

include:
  - nginx.base

/etc/nginx/sites-available/default:
    file.managed:
         - source: salt://nginx/default.conf
         - user: root
         - group: root
         - mode: 644
         - require:
           - pkg: nginx
         - watch_in:
           - cmd: nginx-configtest

/etc/nginx/sites-enabled/default:
    file.symlink:
      - target: /etc/nginx/sites-available/default
      - require:
        - file: /etc/nginx/sites-available/default

{% for setname, domainlist in nginx.domainsets.items() %}
/var/www/{{ setname }}:
    file.directory:
       - user: root
       - group: root
       - dir_mode: 755

/etc/nginx/sites-available/{{ setname }}.conf:
    file.managed:
         - source: salt://nginx/static-content.conf.j2
         - template: jinja
         - user: root
         - group: root
         - mode: 644
         - require:
           - pkg: nginx
         - context:
            setname: {{ setname }}
            domainlist: {{ domainlist }}

/etc/nginx/sites-enabled/{{ setname }}.conf:
    file.symlink:
      - target: /etc/nginx/sites-available/{{ setname }}.conf
      - require:
        - file: /etc/nginx/sites-available/{{ setname }}.conf
{% endfor %}
