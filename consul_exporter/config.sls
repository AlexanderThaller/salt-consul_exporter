{% from 'consul_exporter/map.jinja' import lookup %}
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
        consul_exporter_consul_server="{{ salt['pillar.get']('consul:bind_addr', "localhost") }}:8500"
        consul_exporter_web_listenaddress="{{ salt['pillar.get']('consul_exporter:web_listen-address', ":9107") }}"
{% endif %}

{% if salt['pillar.get']('consul') is defined %}
consul_exporter.consul_service:
  file.managed:
    - name: '{{ salt['file.join'](lookup.consul_service_path, "consul_expoter.json") }}'
    - source: 'salt://consul_exporter/files/consul.json'
{% endif %}
