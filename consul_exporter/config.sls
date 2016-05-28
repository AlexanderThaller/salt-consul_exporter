{% from 'consul/map.jinja' import lookup %}
{% set datamap = salt['pillar.get']('consul') %}

{% if salt['grains.get']('os_family') == 'FreeBSD' %}
consul_exporter.config:
  file.blockreplace:
    - name: '/etc/rc.conf'
    - marker_start: "# START - consul_exporter"
    - marker_end: "# END - consul_exporter"
    - append_if_not_found: True
    - content: |
        # MANAGED BY SALT DO NOT EDIT
        consul_exporter_consul_server="{{ salt['pillar.get']('consul:bind_addr') | default('localhost') }}:8500"
{% endif %}
