{%- from "history/map.jinja" import history with context -%}

history_logrotate_package:
  pkg.installed:
    - name: {{ history.logrotate_package }}

history_log_logrotate_conf_directory:
  file.directory:
    - name: {{ history.logrotate_conf_directory }}
    - require:
      - pkg: history_logrotate_package

history_log_logrotate_conf_file:
  file.managed:
    - name: {{ history.logrotate_conf_directory }}/{{ history.logrotate_conf_file }}
    - source: salt://history/files/logrotate
    - template: jinja
    - require:
      - pkg: history_logrotate_package
      - file: history_log_logrotate_conf_directory

