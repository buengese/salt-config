{% set node_config = salt['pillar.get']('nodes:' ~ grains.id) %}
{% for user in node_config.get('users', {}) %}
test:
   module.run:
      - name: test.echo
      - text: {{ user }}
{% endfor %}
