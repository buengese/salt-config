# only for physical and vms not lxc

ntp:
  pkg.installed: []
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: ntp

/etc/ntp.conf:
  file.managed:
    - source: 
      - salt://ntp/ntp.conf.{{ grains.os }}.{{ grains.oscodename }}
      - salt://ntp/ntp.conf
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: ntp
