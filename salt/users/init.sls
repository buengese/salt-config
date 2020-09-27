{% set node_config = salt['pillar.get']('nodes:' ~ grains.id) %}
{% for user in salt['pillar.get']('users') %}
test:
   module.run:
      - name: test.echo
      - text: {{ user }}
{% endfor %}

/authorized_keys:
  file.managed:
    - source: salt://users/authorized_keys.tmpl
    - template: jinja
      username: root
    - user: root
    - mode: 644
