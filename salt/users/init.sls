{% set node_config = salt['pillar.get']('nodes:' ~ grains.id) %}
{% for user in salt['pillar.get']('users') %}
test:
   module.run:
      - name: test.echo
      - text: {{ user }}
{% endfor %}
