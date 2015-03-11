
{% from "conntrack/map.jinja" import map with context %}

conntrack_sysctl:
  file.managed:
    - name: /etc/sysctl.d/conntrack.conf
    - user: root
    - group: root
    - mode: 600
    - template: jinja
    - source:   salt://conntrack/files/sysctld.jinja

# todo: use salt service state for that
conntrack_reload_sysctl:
  cmd.wait:
    - name: /etc/init.d/{{ map.sysctlservicename }} restart
    - watch:
      - file: /etc/sysctl.d/conntrack.conf


