{% from "conntrack/map.jinja" import map with context %}

install_heartbeat_resource_conntrack-mode:
  file.managed:
    - name {{ resourcepath }}/conntrack-mode:
    - user: root
    - group: root
    - mode: 755
    - source:   salt://conntrack/files/conntrack-mode

install_heartbeat_resource_primary-backup:
  file.managed:
    - name: {{ resourcepath }}/primary-backup:
    - user: root
    - group: root
    - mode: 755
    - source:   salt://conntrack/files/primary-backup


