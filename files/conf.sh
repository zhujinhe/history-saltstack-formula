{%- from "history/map.jinja" import history with context -%}
export HISTTIMEFORMAT=" %F %T "
echo "#$(date +%s)" >> .bash_history
echo '{{ history.login_split }}' >> ~/.bash_history
