{% from 'consul_exporter/map.jinja' import lookup %}

consul_exporter.service:
  service.running:
    - name: {{ lookup.service }}
    - enable: True
    - require:
      - file: 'consul_exporter.binary'
      - file: 'consul_exporter.rc_file'
    - watch:
      - file: 'consul_exporter.config'
