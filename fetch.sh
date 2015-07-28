set -e

P=$1
echo "checking $P"
PAGE=`curl -L --silent "$P"`
URLS=`echo $PAGE | grep -P -o "http://www.bbc.co.uk/programmes/(\w)+#play"`
echo $URLS
for url in $URLS
do
ID=`echo $url | grep -P -o "/(\w)+#" | grep -P -o "(\w)+"`
if [ !  -e ".db/${ID}"  -a  -n "${ID}"  ]
then
  ./download.sh $ID
  touch .db/${ID}
fi
done
