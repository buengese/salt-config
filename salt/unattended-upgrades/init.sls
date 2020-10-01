#
# Unattended Upgrades
#

unattended-upgrades:
  pkg.installed:
    - name: unattended-upgrades

/etc/apt/apt.conf.d/20auto-upgrades:
  file.managed:
    - source: salt://unattended-upgrades/20auto-upgrades

/etc/apt/apt.conf.d/50unattend-upgrades:
  file.managed:
    - source: salt://unattended-upgrades/50unattend-upgrades.{{ grains }}.{{ grains.oscodename }}