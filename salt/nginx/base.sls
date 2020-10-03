#
# Nginx
#

nginx:
  pkg.installed:
    - name: nginx
  service.running:
    - enable: True
    - reuire:
      - pkg: nginx
    - watch:
      - cmd: nginx-configtest

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://nginx/nginx.conf
    - watch_in:
      - cmd: nginx-configtest

/etc/nginx/sites-enabled/default:
  file.absent:
    - watch_in:
      - cmd: nginx-configtest

nginx-configtest:
  cmd.wait:
    - name: /usr/sbin/nginx -t
