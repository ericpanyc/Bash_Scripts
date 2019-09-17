#!/usr/bin/bash
help_message="------------------[OPTIONS]--------------------\n\n--keyword (text)--------------the topic of the wordcloud\n--background (color)----------specify a color for background\n--mask (file)-----------------mask to use for the image form\n--color (color)---------------specify a color for image\n--name (text)-----------------specify the name of the image"
if [ -z "$1" ]; then echo -e $help_message
else
    OPTS=`getopt -o z --long keyword:,background:,mask:,color:,name: -n 'parse-options' -- "$@"`
    if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi

    eval set -- "$OPTS"

    KEYWORD=''
    BACKGROUND=''
    MASK=''
    COLOR=''
    NAME=''

    while true; do
        case "$1" in
            --keyword ) KEYWORD="$2"; shift; shift ;;
            --background ) BACKGROUND="$2"; shift; shift ;;
            --mask ) MASK="$2"; shift; shift ;;
            --color ) COLOR="$2"; shift; shift ;;
            --name ) NAME="$2"; shift; shift ;;
            * ) break ;;
        esac
    done

    esearch -db pubmed -query "$KEYWORD" | efetch -format abstract > pubmed.txt
    wordcloud_cli --text pubmed.txt --imagefile $NAME.png --color $COLOR --background $BACKGROUND --mask ~/Bash_Scripts/$MASK.jpg








fi




