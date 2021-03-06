#
# Nginx
#

nginx:
  pkg.installed:
    - name: nginx
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: nginx
    - watch:
      - cmd: nginx-configtest

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://nginx/files/nginx.conf
    - watch_in:
      - cmd: nginx-configtest

nginx-configtest:
  cmd.wait:
    - name: /usr/sbin/nginx -t
