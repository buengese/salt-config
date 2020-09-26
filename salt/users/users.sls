{% set node_config = salt['pillar.get']('nodes:' ~ grains.id) %}

module.run:
  test.echo:
    test: {{ node_config }}