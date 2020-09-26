editor installed:
    pkg.installed:
      - name: {{ salt['pillar.get']('editor') }}
