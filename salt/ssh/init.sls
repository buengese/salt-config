{% from "ssh/map.jinja" import ssh with context %}
#
# SSH daemon configuration
#

ssh:
{% if grains['os_family'] == 'Debian' %}
  pkg.installed:
    - name: "openssh-server"
{% endif %}
  service.running:
    - name: {{ ssh.service }}
    - enable: True
    - reload: True

/etc/ssh/sshd_config:
  file.managed:
    - source:
{% if grains['kernel'] == 'Linux' %}
      - salt://ssh/sshd_config.{{ grains.os }}.{{ grains.oscodename }}
{% endif %}
      - salt://ssh/sshd_config.{{ grains.os }}
      - salt://ssh/sshd_config
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: ssh