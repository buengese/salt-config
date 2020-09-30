{% from "rclone/map.jinja" import rclone with context %}

rclone:
  pkg.installed:
    - sources:
        - rclone: {{ rclone.pkg }}
