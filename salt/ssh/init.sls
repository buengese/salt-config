#
# SSH daemon configuration
#

ssh:
  pkg.installed:
    - name: "openssh-server"
  service.running:
    - enable: True
    - reload: True

/etc/ssh/sshd_config:
  file.managed:
    - source:
      - salt://ssh/sshd_config.{{ grains.os }}.{{ grains.oscodename }}
      - salt://ssh/sshd_config
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: ssh