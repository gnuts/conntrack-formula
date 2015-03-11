{% from "heartbeat/map.jinja" import map with context %}

conntrack_packages:
  pkg.installed:
    - pkgs:
      {% for pkg in map.pkgs %}
      - {{pkg }}
      {% endfor %}

conntrack_conntrackdconf:
  file.managed:
    - name: {{ map.confdir }}/conntrackd.conf
    - user: root
    - group: root
    - mode: 600
    - template: jinja
    - source:   salt://conntrack/files/conntrackdconf.jinja
    - context:
      address:     {{ pillar.conntrack.get('address', 'NOT CONFIGURED') }}
      destination: {{ pillar.conntrack.get('destination', 'NOT CONFIGURED') }}
      interface:   {{ pillar.conntrack.get('interface', 'eth0') }}
      ignore:      {{ pillar.conntrack.get('ignore', []) }}

reload_conntrackd:
  cmd.wait:
    - name: /etc/init.d/{{map.servicename}} reload
    - watch:
      - file: /etc/conntrackd/conntrackd.conf

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


