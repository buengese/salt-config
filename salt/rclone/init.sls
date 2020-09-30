{% from "rclone/map.jinja" import rclone with context %}

rclone:
  pkg.installed:
    - sources:
        - rclone: {{ rclone.pkg }}

{% set user = salt['pillar.get']('node:rclone:user') %}
  {% set path = '/' + user %}
  {% if user not in ['root'] %}
    {% set path = '/home' + path %}
  {% endif %}

{{ path }}/.config:
  file.directory:
    - user: {{ user }}
    - group: {{ group }}
    - mode: 755
    - rquire:
      - user: ssh-{{ user }}

{{ path }}/.config/rclone:
  file.directory:
    - user: {{ user }}
    - group: {{ group }}
    - mode: 755
    - require:
      - file: {{ path }}/.config

{{ path }}/.config/rclone/rclone.conf:
  file.managed:
    - source: salt://rclone/rclone.conf
    - template: jinja
    - user: {{ user }}
    - mode: 750
    - require:
      - file: {{ path }}/.config/rclone