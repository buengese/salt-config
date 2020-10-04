{% from "users/map.jinja" import settings with context %}
{% set node_config = salt['pillar.get']('node') %}

{% set users = ['root'] %}
{% for user in node_config.get('users', []) if user not in users %}
  {% do users.append(user) %}
{% endfor %}

{% for user in users %}
  {% set group = user %}
  {% if user in ['root'] and grains['kernel'] in ['FreeBSD'] %}
    {% set group = 'wheel' %}
  {% endif %}
  {% set path = '/' + user %}
  {% if user not in ['root'] %}
    {% set path = '/home' + path %}
  {% endif %}

ssh-{{ user }}:
  user.present:
    - name: {{ user }}
    - shell: {{ settings.shell }}
    - home: {{ path }}
    - createhome: True
    - usergroup: True
    - system: False

{{ path }}/.ssh:
  file.directory:
    - user: {{ user }}
    - group: {{ group }}
    - mode:  700
    - require:
      - user: ssh-{{ user }}

{{ path }}/.ssh/authorized_keys:
  file.managed:
    - source: salt://users/authorized_keys.tmpl
    - template: jinja
      username: {{ user }}
    - user: {{ user }}
#   - group: {{ group }}
    - mode: 644
    - require:
      - file: {{ path }}/.ssh
{% endfor %}