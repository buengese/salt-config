{% from "nginx/map.jinja" import nginx with context %}

include:
  - nginx.install

/etc/nginx/sites-available/default:
    file.managed:
         - source: salt://nginx/files/default.conf
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

{% for setname, contents in nginx.domainsets.items() %}
/var/www/{{ setname }}:
    file.directory:
       - user: root
       - group: root
       - dir_mode: 755

/etc/nginx/sites-available/{{ setname }}.conf:
    file.managed:
{% if contents.park %}
         - source: salt://nginx/files/cats.conf.j2
{% else %}
         - source: salt://nginx/files/static-content.conf.j2
{% endif %}
         - template: jinja
         - user: root
         - group: root
         - mode: 644
         - require:
           - pkg: nginx
         - watch_in:
           - cmd: nginx-configtest
         - context:
             setname: {{ setname }}
             domainlist: {{ contents.domains }}

/etc/nginx/sites-enabled/{{ setname }}.conf:
    file.symlink:
      - target: /etc/nginx/sites-available/{{ setname }}.conf
      - require:
        - file: /etc/nginx/sites-available/{{ setname }}.conf
{% endfor %}
