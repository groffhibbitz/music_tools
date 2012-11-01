#!/bin/bash 

IFS=$'\t\n'

#i="340498_Waves_And_Sun_African_Waves_Mix_Dorfmeister.mp3" 
for i in *.mp3; do
	#if this mp3 doesn't have id3v2 information, only id3v1 info, then convert the tag
	tag=`id3v2 -l $i | grep "id3v2"`
	if [ -z $tag ]; then
		echo "converting id3 tag"
		id3v2 -C $i
	fi
	album=`id3v2 -l $i | grep "TAL (" | sed 's/.*: //'`
	if [ -z $album ]; then
        album=`id3v2 -l $i | grep "TALB (" | sed 's/.*: //'`
        if [ -z $album ]; then
            echo "could not find album for: $i"
            continue
        fi
	fi

    `mkdir -p $album; mv $i $_`

done
