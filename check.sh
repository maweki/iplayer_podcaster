set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR

while read p; do
  PROG=`echo $p | grep -P -o "^(\w)+"`
  ./fetch.sh "http://www.bbc.co.uk/programmes/${PROG}/episodes/player"
done <./programmes
