{% from "node_exporter/map.jinja" import node_exporter with context %}
prometheus-node-exporter:
  service.running:
    - enable: True
    - full_restart: True

config_file:
  file.managed:
    - name: {{ node_exporter.config }}
    - source: salt://node_exporter/files/prometheus-node-exporter.{{ grains.os_family }}.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: prometheus-node-exporter
