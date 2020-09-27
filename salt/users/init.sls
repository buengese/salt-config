{% set node_config = salt['pillar.get']('nodes:' ~ grains.id) %}
{% for user in node_config.get('users', {}) if True %}
test:
   module.run:
      - name: test.echo
      - text: {{ user }}
{% endfor %}
