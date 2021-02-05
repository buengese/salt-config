{% from "matrix-synapse/map.jinja" import matrix with context %}

/etc/matrix-synapse/homeserver.yaml:
    file.managed:
        - source: salt://matrix-synapse/files/homeserver.yaml.j2
        - template: jinja
        - user: root
        - group: root
        - mode: 644

/etc/matrix-synapse/conf.d/server_name.yaml:
    file.managed:
        - source: salt://matrix-synapse/files/server_name.yaml.j2
        - template: jinja
        - user: root
        - group: root
        - mode: 644
