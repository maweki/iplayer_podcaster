set -e

TARGET="~/Downloads/dta/"
TMPDIR="/tmp/"
PROG=$1

echo $PROG
RTMPLINE=`curl --silent --data "pid="$PROG http://www.iplayerconverter.co.uk/convert.aspx | grep RTMPDump | grep -P -o "\-r.+\-o"`
COMMAND="rtmpdump -q $RTMPLINE ${TMPDIR}${PROG}.flv"
echo $COMMAND > ${TMPDIR}${PROG}.sh
rm -f ${TMPDIR}${PROG}.flv
bash ${TMPDIR}${PROG}.sh
rm ${TMPDIR}${PROG}.sh
mv ${TMPDIR}${PROG}.flv ${TARGET}${PROG}.flv
