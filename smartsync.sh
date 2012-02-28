#! /bin/bash

# 	Welcome to the
# Im too lazy to pick out songs
# So i want my app to sync my flash music
# to my phone storage Device.
#
#		Created by: J3K47

# Create Directory on destination for the day (Gotsto be organised)
mkdir /media/BLACKBERRY/$(date +%m%d)

# Specifiy Directory
DIR=/media/BLACKBERRY/$(date +%m%d)/

# Check if Flash drive with Media Is Present
if [ "$(ls -d '/media/JUSTIN' )" = /media/JUSTIN ]; then
	echo "JACKED"

		# Check if Destination Media Is Present
		if [ "$(ls -d '/media/BLACKBERRY' )" = /media/BLACKBERRY ]; then
			echo "BLACKJACKED"

			# Sync the media over to destination
			[  "$(scp -vr /media/JUSTIN/*.mp3 $DIR)" ]
			echo "done!"
		else

			# Destination Device Not Present Identifier
			echo "BLACK NOT JACKED"
		fi
else

	# Source Device Not Present Identifre
	echo "NOT JACKED"
fi
