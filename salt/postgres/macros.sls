{% from "postgres/map.jinja" import pgsql with context %}
# postgresql user macros

{% macro pg_user(name, password) %}
pg_user-{{ name }}:
    postgres_user.present:
        - name: {{ name }}
        - password: {{ password }}
        - encrypted: True
        - user: postgres
{% endmacro %}

{% macro pg_database(name, encoding, lc_collate, lc_ctype, template, owner) %}
pg_database-{{ name }}:
    postgres_database.present:
        - name: {{ name }}
        - encoding: {{ encoding }}
        - lc_collate: {{ lc_collate }}
        - lc_ctype: {{ lc_ctype }}
        - template: {{ template }}
        - owner: {{ owner }}
{% endmacro %}

{% macro pg_auth(name, database) %}
/etc/postgresql/{{ pgsql.version }}/main/pg_hba.conf:
    file.managed:
        - source: salt://postgres/pg_hba.conf.j2
        - template: jinja
          pg_user: {{ name }}
          pg_db: {{ database }}
        - user: postgres
        - group: postgres
        - mode: 640
{% endmacro %}