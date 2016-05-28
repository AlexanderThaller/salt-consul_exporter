{% from 'consul_exporter/map.jinja' import lookup %}

consul_exporter.binary:
  file.managed:
    - name: '{{ salt['file.join'](lookup.bin_path, 'consul_exporter') }}'
    - source: 'salt://consul_exporter/files/binary/FreeBSD/consul_exporter'
    - mode: '0755'

consul_exporter.rc_file:
  file.managed:
    - name: '{{ salt['file.join'](lookup.rc_path, 'consul_exporter') }}'
    - source: 'salt://consul_exporter/files/rc.FreeBSD'
    - mode: '0755'
