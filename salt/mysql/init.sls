
mysql:
  pkg.installed:
    - pkgs:
      - mysql-server
      - mysql-client
  service.running:
    - name: mysql
    - enable: True

python-mysql:
  pkg.installed:
    - name: python3-pymysql
    - require:
      - pkg: mysql
