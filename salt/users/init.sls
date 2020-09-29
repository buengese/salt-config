{% set node_config = salt['pillar.get']('node') %}

{% set users = ['root'] %}
{% for user in node_config.get('users', []) if user not in users %}
  {% do users.append(user) %}
{% endfor %}

{% for user in users %}
  {% set path = '/' + user %}
  {% if user not in ['root'] %}
    {% set path = '/home' + path %}
  {% endif %}

ssh-{{ user }}:
  user.present:
    - name: {{ user }}
    - shell: /bin/bash
    - home: {{ path }}
    - createhome: True
    - usergroup: True
    - system: False

{{ path }}/.ssh:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - mode:  700

/authorized_keys:
  file.managed:
    - source: salt://users/authorized_keys.tmpl
    - template: jinja
      username: {{ user }}
    - user: {{ user }}
    - mode: 644
{% endfor %}