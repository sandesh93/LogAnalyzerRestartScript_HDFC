#!/bin/bash
BASEDIR="/home/appsone/Log_Monitoring_Tool"
SCRIPT_NAME="Master_Log_Analyzer.sh"
PID=$(ps -ef|grep Log_Analyzer.sh|grep -v grep |awk '{print $2}')

#echo "Base Directory is " $BASEDIR
#echo "Log analyzer is running with pid= "$PID

if [  -z $PID ]
then
        $(rm -f $BASEDIR/*.out)
        $(rm -f $BASEDIR/lib/*lock*)
        $(rm -rf $BASEDIR/log $BASEDIR/tmp $BASEDIR/ProcessedLogs)
        cd $BASEDIR; sh -x $SCRIPT_NAME   > /dev/null 2>&1
        sleep 2
        PID=$(ps -ef|grep Log_Analyzer.sh|grep -v grep |awk '{print $2}')
        echo "Process Started with PID= "$PID > $BASEDIR/status.txt
        echo "Process Started at `date`" >> $BASEDIR/status.txt
        echo "----END-----" >> $BASEDIR/status.txt
else
        $(kill -9 $PID)
        $(rm -f $BASEDIR/lib/*lock*)
        $(rm -f $BASEDIR/*.out)
        $(rm -rf $BASEDIR/log $BASEDIR/tmp $BASEDIR/ProcessedLogs)
        cd $BASEDIR ;sh -x $SCRIPT_NAME  > /dev/null 2>&1
        sleep 2
        PID=$(ps -ef|grep Log_Analyzer.sh|grep -v grep |awk '{print $2}')
        echo "Process Re-Started with PID= "$PID > $BASEDIR/status.txt
        echo "Process Re-Started at `date`"  >> $BASEDIR/status.txt
        echo "----END---" >> $BASEDIR/status.txt
fi

exit 0