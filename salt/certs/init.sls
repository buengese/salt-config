#
# SSL Certificates
#

openssl:
  pkg.installed:
    - name: openssl

# debian ubuntu only
{% if grains['os_family'] in ['Debian'] %}
ssl-cert:
  pkg.installed:
    - name: ssl-cert

update_ca_certificates:
  cmd.wait:
    - name: /usr/sbin/update-ca-certificates
    - watch: []

{% endif %}

generate-dhparam:
  cmd.run:
    - name: openssl dhparam -out /etc/ssl/dhparam.pem 2048
    - creates: /etc/ssl/dhparam.pem

# Install internal CA cert using Debian
# cert mangling mechanism
# TODO: install on freebsd
{% if grains['os_family'] == 'Debian' %}
/usr/local/share/ca-certificates/bngs-ca.crt:
  file.managed:
    - source: salt://certs/cacert.pem
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - cmd: update_ca_certificates
{% endif %}

{% set certs = {} %}
{% set node_config = salt['pillar.get']('node') %}
{% for cn, cert_config in node_config.get('certs', {}).items() %}
  {% if 'cert' in cert_config and 'privkey' in cert_config %}
    {% set pillar_name = 'node:certs:' ~ cn %}
  {% endif %}
  {% if pillar_name != None %}
    {% do certs.update({ cn : pillar_name }) %}
  {% endif %}
{% endfor %}

{% for cn, pillar_name in certs.items() %}
/etc/ssl/certs/{{ cn }}.cert.pem:
  file.managed:
    - contents_pillar: {{ pillar_name }}:cert
    - user: root
    - group: root
    - mode: 644

/etc/ssl/private/{{ cn }}.key.pem:
  file.managed:
    - contents_pillar: {{ pillar_name }}:privkey
    - user: root
    - group: ssl-cert
    - mode: 440
    - require:
      - pkg: ssl-cert
{% endfor %}

