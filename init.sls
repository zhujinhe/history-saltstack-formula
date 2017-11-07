{%- from "history/map.jinja" import history with context -%}

history_conf_directory:
  file.directory:
    - name: {{ history.conf_directory }}

history_conf_file:
  file.managed:
    - name: {{ history.conf_directory }}/{{ history.conf_file }}
    - source: salt://history/files/conf.sh
    - template: jinja
    - require:
      - file: history_conf_directory

{%- for script in history.scripts_list %}
history_scripts_file_{{ script }}:
  file.managed:
    - name: {{ script }}
    - source: salt://history/files/scripts_file
    - mode: 755
    - template: jinja
    - require:
      - file: history_conf_file
{%- endfor %}

history_log_directory:
  file.directory:
    - name: {{ history.log_directory }}
    - mode: 755
    - require:
      - file: history_conf_file

history_log_file:
  file.managed:
    - name: {{ history.log_directory }}/{{ history.log_file }}
    - user: root
    - group: root
    - mode: 222
    - attrs: a
    - require: 
      - file: history_log_directory

{% if history.logrotate %}

include:
  - history.logrotate

{%- endif -%}
