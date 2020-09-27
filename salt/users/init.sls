{% set node_config = salt['pillar.get']('node') %}
{% for user in node_config.get('users', []) %}
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
