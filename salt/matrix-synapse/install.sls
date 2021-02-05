
include:
    - apt.transport-https

matrix-org:
  pkgrepo.managed:
    - humanname: matrix-org
    - name: deb https://packages.matrix.org/debian/ {{ grains.oscodename }} main
    - key_url: salt://matrix-synapse/files/matrix-org-archive-keyring.gpg
    - file: /etc/apt/sources.list.d/matrix-org.list
    - clean_file: True
    - refresh: True
    - require_in:
      - pkg: matrix-synapse-py3
    - require:
      - pkg: apt-transport-https
  pkg.installed:
    - name: matrix-synapse-py3

{% from "matrix-synapse/map.jinja" import matrix with context %}
{% from "postgres/macros.sls" import pg_user, pg_database, pg_auth with context %}

{{ pg_user(matrix.database.user, matrix.database.password) }}

{{ pg_database(matrix.database.name, "UTF8", "C", "C", "template0", matrix.database.user) }}

{{ pg_auth(matrix.database.user, matrix.database.name) }}
