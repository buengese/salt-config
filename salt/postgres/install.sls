
postgresql:
  pkg.installed:
    - pkgs:
      - postgresql
  service.running:
    - name: postgresql
    - enable: True
    - require:
        - pkg: postgresql