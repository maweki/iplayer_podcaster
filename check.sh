set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR

while read p; do
  PROG=`echo $p | grep -P -o "^(\w)+"`
  PAGE=`curl -L --silent "http://www.bbc.co.uk/programmes/${PROG}/broadcasts/"`
  URLS=`echo $PAGE | grep -P -o "http://www.bbc.co.uk/programmes/(\w)+#auto"`
  for url in $URLS
  do
    ID=`echo $url | grep -P -o "/(\w)+#" | grep -P -o "(\w)+"`
    if [ !  -e ".db/${url}"  -a  -n "${url}"  ]
    then
      ./download.sh $ID
      touch .db/${url}
    fi
  done
done <./programmes
