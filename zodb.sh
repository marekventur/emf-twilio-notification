#!/bin/bash
PATH=/usr/local/bin:/bin:/usr/bin
DAEMON="Indico"
ZODB_CMD="zdaemon -C /opt/indico/etc/zdctl.conf"
INDICO_CMD="sudo -u www-data /usr/local/bin/indico_scheduler"
# INDICO_CMD="python /usr/local/lib/python2.6/dist-packages/cds_indico-0.97.1-py2.6.egg/MaKaC/consoleScripts/taskDaemon.py"
## INDICO_CMD="python /usr/lib/python2.5/site-packages/cds_indico-0.97b-py2.5.egg/MaKaC/consoleScripts/taskDaemon.py"
# Get lsb functions
. /lib/lsb/init-functions
. /etc/default/rcS
case "$1" in
 start)
  log_begin_msg "Starting $DAEMON services..."
#   $DAEMON $OPTIONS_START
  $ZODB_CMD start
  $INDICO_CMD -f start
  log_end_msg $?
  ;;
 stop)


  log_begin_msg "Stopping $DAEMON services..."
#   $DAEMON $OPTIONS_STOP
  $ZODB_CMD stop
  kill -TERM `ps aux|grep indico|grep -v grep| awk '{print $2}'`
  kill -KILL `ps aux|grep indico|grep -v grep| awk '{print $2}'`
  #$INDICO_CMD stop
  log_end_msg $?
  ;;
 restart)
  $0 stop
  $0 start
  ;;
 *)
  echo "Usage: $0 {start|stop|restart}"
  exit 1
esac
exit 0