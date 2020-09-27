{% set node_config = salt['pillar.get']('node') %}

{% set users = ['root'] %}
{% for user in node_config.get('users', []) if user not in users %}
  {% do users.append(user) %}
{% endfor %}

{% for user in users if user not in ['root'] %}
  {% set path = '/home/' + user %}

{# Create user if not present#}
ssh-{{ user }}:
  user.present:
    - name: {{ user }}
    - shell: /bin/bash
    - home: {{ path }}
    - createhome: True
    - gid_from_name: True
    - system: False

test:
   module.run:
      - name: test.echo
      - text: {{ user }}
{% endfor %}

/authorized_keys:
  file.managed:
    - source: salt://users/authorized_keys.tmpl
    - template: jinja
      username: root
    - user: root
    - mode: 644
