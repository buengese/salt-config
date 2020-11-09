#
# Unbound (DNS resolver)
#
unbound:
  pkg.installed: []

/usr/local/etc/unbound/unbound.conf:
    file.managed:
    - source: salt://unbound/unbound.conf.tmpl
    - template: jinja
    - user: unbound
    - group: wheel
    - mode: 644
    - require:
      - pkg: unbound

/usr/local/etc/unbound/domainoverrides.conf:
    file.managed:
    - source: salt://unbound/domainoverrides.conf.tmpl
    - template: jinja
    - user: unbound
    - group: wheel
    - mode: 644
    - require:
      - pkg: unbound
