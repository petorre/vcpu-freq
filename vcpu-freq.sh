#! /bin/bash

METRICNAME="f"

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]; then
	echo "Usage: $0 <NODENAME> <PUSHGWIP> <interval>"
	exit 1
fi

NODENAME=$1
PUSHGWIP=$2
INTERVAL=$3

while [ true ]; do
	i=0
	for f in ` grep -i mhz /proc/cpuinfo | awk ' { print $4 } ' `; do
		# echo "f(vCPU${i})=${f}"
		echo "${METRICNAME} ${f}" | curl --noproxy $PUSHGWIP --connect-timeout 2 --data-binary @- "http://$PUSHGWIP:9091/metrics/job/vCPU${i}/instance/${NODENAME}"
		((i++))
	done
	echo -n "."
	sleep ${INTERVAL}
done
