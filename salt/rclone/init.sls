{% from "rclone/map.jinja" import rclone with context %}

rclone:
  pkg.installed:
    - sources:
        - rclone: {{ rclone.pkg }}

{% set user = pillar['node']['rclone']['user'] %}
{% set path = '/' + user %}
{% if user not in ['root'] %}
  {% set path = '/home' + path %}
{% endif %}

{% if user not in salt['user.list_users']() and raise('user must exist') %}
{% endif %}

{{ path }}/.config:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755

{{ path }}/.config/rclone:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - require:
      - file: {{ path }}/.config

{{ path }}/.config/rclone/rclone.conf:
  file.managed:
    - source: salt://rclone/rclone.conf.j2
    - template: jinja
    - user: {{ user }}
    - mode: 750
    - require:
      - file: {{ path }}/.config/rclone
