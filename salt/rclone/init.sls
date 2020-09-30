{% from "salt/map.jinja" import salt with context %}

rclone:
  pkg.installed:
    - sources:
        - rclone: {{ rclone.pkg }}