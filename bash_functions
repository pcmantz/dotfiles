# -*- Mode: shell-script -*-

function show_path {
    echo $PATH | sed -e 's|:|\n|g'
}

function where_pm {
    MODULE=$1
    REL_PATH=`echo $MODULE | sed -e 's|::|/|g'`.pm
    perl -M${MODULE} -E "say \$INC{q{$REL_PATH}};"
}

 # Handy Extract Program.
function extract {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
         esac
    else
        echo "'$1' is not a valid file"
    fi
}

function scroll-colors {
    x=`tput op`
    y=`printf %80s`
    for i in {0..256}; do
        o=00$i
        echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;
    done
}

function up {
    usage='USAGE: up <number>'
    if [[ $# -ne 1 ]] ; then 
        echo $usage && exit 65
    fi

    num=$1
    upstr='.'
    iter=0
    until [ $iter -eq $num ] ; do
        upstr="${upstr}/.."
        let iter=iter+1
    done
    cd $upstr
}
