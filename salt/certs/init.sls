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
    - name: openssl dhpram -out /etc/ssl/dhparam.pem 2048
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
