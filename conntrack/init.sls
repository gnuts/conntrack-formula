{% from "conntrack/map.jinja" import map with context %}

conntrack_packages:
  pkg.installed:
    - pkgs:
      {% for pkg in map.pkgs %}
      - {{ pkg }}
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
      lockfile:    {{ map.lockfile }}
      unixpath:    {{ map.unixpath }}

restart_conntrackd:
  cmd.wait:
    - name: /etc/init.d/{{map.servicename}} restart
    - watch:
      - file: /etc/conntrackd/conntrackd.conf


