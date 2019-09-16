#!/usr/bin/bash
help_message="\n\n-------------------------Preparation---------------------------\n\nIf you are first using this script, please first install the following tools:\n1.Entrez Direct-----------https://www.ncbi.nlm.nih.gov/books/NBK179288/\n2.word_cloud---------------https://github.com/amueller/word_cloud\n\n------------------[OPTIONS]--------------------\n\n--keyword (text)--------------the topic of the wordcloud\n--background (color)----------specify a color for background\n--mask (file)-----------------mask to use for the image form\n--color (color)---------------specify a color for image"
if [ -z "$1" ]; then echo -e $help_message
else
    OPTS=`getopt -o z --long keyword:,background:,mask:,color: -n 'parse-options' -- "$@"`
    if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi

    eval set -- "$OPTS"

    KEYWORD=''
    BACKGROUND=''
    MASK=''
    COLOR=''

    while true; do
        case "$1" in
            --keyword ) KEYWORD="$2"; shift; shift ;;
            --background ) BACKGROUND="$2"; shift; shift ;;
            --mask ) MASK="$2"; shift; shift ;;
            --color ) COLOR="$2"; shift; shift ;;
            * ) break ;;
        esac
    done

    esearch -db pubmed -query "$KEYWORD" | efetch -format abstract > pubmed.txt
    wordcloud_cli --text pubmed.txt --imagefile wordcloud.png








fi




