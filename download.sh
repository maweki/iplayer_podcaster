set -e

TARGET="/home/maweki/Downloads/dta/"
TMPDIR="/tmp/"
PROG=$1

rm -f ${TMPDIR}${PROG}.*
RTMPLINE=`curl --silent --data "pid="$PROG http://www.iplayerconverter.co.uk/convert.aspx | grep RTMPDump | grep -P -o "\-r.+\-o"`
COMMAND="rtmpdump -q $RTMPLINE ${TMPDIR}${PROG}.flv"
echo $COMMAND > ${TMPDIR}${PROG}.sh
bash ${TMPDIR}${PROG}.sh
rm ${TMPDIR}${PROG}.sh
vlc -I dummy --sout "#transcode{acodec=mp3,ab=128,channels=2}:std{access=file,mux=raw,dst=${TMPDIR}${PROG}.mp3}" ${TMPDIR}${PROG}.flv vlc://quit
rm ${TMPDIR}${PROG}.flv
mv ${TMPDIR}${PROG}.mp3 ${TARGET}${PROG}.mp3
