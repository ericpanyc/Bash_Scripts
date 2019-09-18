#!/usr/bin/bash
help_message="------------------[OPTIONS]--------------------\n\n--keyword (text)--------------the topic of the wordcloud\n--background (color)----------specify a color for background\n--mask (file)-----------------mask to use for the image form\n--color (color)---------------specify a color for image\n--name (text)-----------------specify the name of the image\n\nPlease use double quote \"\" to include all your terms you want to look up, and delimit each of them by a space.\n\nBased on the terms you input, it might take a rather long time to fetch data from the NCBI database and then generate the word cloud, so, please have a cup of coffee and be patient."

if [ -z "$1" ]; then echo -e $help_message
else
    if [ -f pubmed.txt ]; then rm pubmed.txt; fi
    find . -name "*.png" -type f|xargs rm -f
    
    OPTS=`getopt -o z --long term:,background:,mask:,color:,name: -n 'parse-options' -- "$@"`
    if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi
    eval set -- "$OPTS"

    TERM=''
    BACKGROUND='black'
    MASK=''
    COLOR='red'
    NAME='wordcloud'

    while true; do
        case "$1" in
            --term ) TERM="$2"; shift; shift ;;
            --background ) BACKGROUND="$2"; shift; shift ;;
            --mask ) MASK="$2"; shift; shift ;;
            --color ) COLOR="$2"; shift; shift ;;
            --name ) NAME="$2"; shift; shift ;;
            * ) break ;;
        esac
    done

    esearch -db pubmed -query "$TERM" | efetch -format abstract > pubmed.txt
    if  [ -z "$MASK" ]
    then
        wordcloud_cli --text pubmed.txt --imagefile $NAME.png --color $COLOR --background $BACKGROUND
    else
        wordcloud_cli --text pubmed.txt --imagefile $NAME.png --color $COLOR --background $BACKGROUND --mask $MASK.jpg
    fi
fi




