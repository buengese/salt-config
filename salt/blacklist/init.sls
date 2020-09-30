# Kernel module blacklist - physical only

/etc/modprobe.d/blacklist.conf:
  file.managed:
    - source: salt://blacklist/blacklist.conf
    - user: root
    - group: root
    - mode: 644
  - cmd.run:
    - name: /usr/sbin/update-initramfs -u
    - onchanges:
      - file: /etc/modprobe.d/blacklist.conf
