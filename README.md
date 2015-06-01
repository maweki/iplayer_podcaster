# iplayer_podcaster

Download iPlayer radio-shows as if they were podcasts and converts them to mp3 to listen to on your phone or mp3-player. This script uses the iplayerconverter.co.uk webservice. Please do not abuse this service. I run `check.sh` once a day.

## Requirements

* vlc
* rtmpdump
* curl
* have the `.db` subdirectory user-writable

## Usage

1. open the bbc website of your favorite radio-show and find out the show's id.
2. edit the `programmes` file, adding the ids of your favorite show
3. edit the `download.sh` file and change the target path (where the mp3s are moved to) and a path where the tempfiles are generated.
4. execute `check.sh` and wait for the magic to happen

I have it in my crontab like that:
`0 13 * * * bash /home/maweki/s/bbc_podcaster/check.sh >/dev/null 2>&1`

## How it works

1. runs through the `programmes` file and extract show ids.
2. fetches the available-episodes page of the shows and finds all available episodes
3. checks the available episodes against the "database"
4. for the missing episodes, fetch the rtmpdump-command from the iplayerconverter-service
5. use rtmpdump to fetch the flv-file with the episode
6. use vlc to convert the flv to mp3
7. move the mp3 to the target directory and remove temporary files
8. add the episode id to the database
9. listen and enjoy
