#!/bin/bash

#VARIAVEIS NAGIOS
NAGIOS_OK=0
NAGIOS_WARNING=1
NAGIOS_CRITICAL=2
NAGIOS_UNKNOWN=3

PROGNAME=`basename $0 .sh`
VERSION="Version 1.0"

WGET=/usr/bin/wget
GREP=/bin/grep

print_version() {
    echo "$VERSION"
}

print_help() {
    print_version $PROGNAME $VERSION
    echo ""
    echo "$PROGNAME is a Nagios plugin to check a specific Tomcat Application."
    echo ""
    echo "$PROGNAME -u user -p password -h host -P port -a application"
    echo ""
    echo "Options:"
    echo "  -u/--user)"
    echo "     User name for authentication on Tomcat Manager Application"
    echo "  -p/--password)"
    echo "     Password for authentication on Tomcat Manager Application"
    echo "  -H/--host)"
    echo "     Host Name of the server"
    echo "  -P/--port)"
    echo "     Port Number Tomcat service is listening on"
    echo "  -a/--appname)"
    echo "     Application name to be checked"
    exit $ST_UK
}

if [ ! -x "$WGET" ]
then
  echo "wget not found!"
	exit $NAGIOS_CRITICAL
fi

if [ ! -x "$GREP" ]
then
	echo "grep not found!"
	exit $NAGIOS_CRITICAL
fi




if test -z "$1"
then
	print_help
	exit $NAGIOS_CRITICAL
fi

while test -n "$1"; do
    case "$1" in
        --help|-h)
            print_help
            exit $ST_UK
            ;;
        --version|-v)
            print_version $PROGNAME $VERSION
            exit $ST_UK
            ;;
        --user|-u)
            USER=$2
            shift
            ;;
        --password|-p)
            PASSWORD=$2
            shift
            ;;
        --host|-H)
            HOST=$2
            shift
            ;;
        --port|-P)
            PORT=$2
            shift
            ;;
        --appname|-a)
            APP=$2
            shift
            ;;
        *)
            echo "Unknown argument: $1"
            print_help
            exit $ST_UK
            ;;
        esac
    shift
done


if wget -o /dev/null -O - http://$USER:$PASSWORD@$HOST:$PORT/manager/list | grep -q "^/$APP:running"  
then
        return_status="OK: Application $APP is running!"

 	wget -o /dev/null -O - http://$USER:$PASSWORD@$HOST:$PORT/manager/status?XML=true |sed -e "s/\/>/\/>\n/g"|egrep "(connector|requestInfo)"|sed -e "s/\"//g"|awk -v app=$APP '{
	if ($0 ~ "connector name=")  { value=$2; all=substr(value,7,15);  ncount=index(all,"<")-3; connector=substr(all,0,ncount);}
	if ($0 ~ "<requestInfo") {  print app"_"connector" OK:|"connector"_"$2"ms;;;0 "connector"_"$3"ms;;;0 "connector"_"$4"ms;;;0 "connector"_"$5"ms;;;0 "connector"_"$6"ms;;;0 "connector"_"$7"ms;;;0"; } ;}'

        exit $NAGIOS_OK

else
         echo "CRITICAL: Application $APP is not running!"
        exit $NAGIOS_CRITICAL
fi
