#
# TheLonge IRC Client
# 

thelounge:
  pkg.installed:
{% if grains['os_family'] == 'Debian' %}
    - sources:
      - thelounge: salt://thelounge/thelounge_4.2.0_all.deb
{% endif %}
  service.running:
    - enable: True
    - require:
      - pkg: thelounge

/etc/thelounge/config.js:
  file.managed:
    - source: salt://thelounge/config.js
    - user: thelounge
    - group: thelounge
    - mode: 660
    - require:
      - pkg: thelounge
    - watch_in:
      - service: thelounge