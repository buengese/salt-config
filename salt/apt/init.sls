#
# APT
#
include:
  - apt.transport-https

/etc/apt/sources.list:
  file.managed:
{% if grains.virtual == "LXC" %}
    - source: salt://apt/sources.list.{{ grains.os }}.{{ grains.oscodename }}.lxc
{% else %}
    - source: salt://apt/sources.list.{{ grains.os }}.{{ grains.oscodename }}
{% endif %}

/etc/apt/sources.list.d/saltstack.list:
  file.managed:
    - source: salt://apt/saltstack.list.{{ grains.os }}.{{ grains.oscodename }}
    - reuire:
      - pkg: apt-transport-https


/etc/cron.d/apt:
  file.managed:
    - source: salt://apt/update_apt.cron
