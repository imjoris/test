#!/bin/bash

# http://linux.die.net/man/1/twopi
# dot - filter for drawing directed graphs
# neato - filter for drawing undirected graphs
# twopi - filter for radial layouts of graphs
# circo - filter for circular layout of graphs
# fdp - filter for drawing undirected graphs
# sfdp - filter for drawing large undirected graphs

graphTypes='
dot
neato
twopi
circo
fdp
sfdp 
'

#dot
#horizonDot

horizonDotWithS
dotWithS
dotTypes='
dot
horizonDot
'

processDotFile(){
    dotFile="$1";
    dotType="$2";

    libName="${dotFile%*Gaph.dot}";
    libName="${libName##*/}";
    # echo "$libName"

    outDir='pngFiles/'"$2"'/'"$libName"'/';
    mkdir -p "$outDir";

    if [ $dotType != "dot" ]; then
        if [ $dotType != "horizonDot" ]; then
            echo "$libName";
            # circo -Goverlap=false -Nshape=point -Earrowsize=0.35 -Tpng -o "$outDir"'circoPoint.png' "$dotFile";
            # circo -Goverlap=false -Earrowsize=0.35 -Tpng -o "$outDir"'circo.png' "$dotFile";
        fi
    fi

    # neato -Goverlap=false -Tpng -o "$outDir"'neato.png' "$dotFile";
    # twopi -Goverlap=false -Tpng -o "$outDir"'twopi.png' "$dotFile";
    dot -Goverlap=false -Tpng -o "${outDir}"'dot.png' "$dotFile";
    # fdp -Goverlap=false -Tpng -o "${outDir}"'fdp.png' "$dotFile";
    # sfdp -Goverlap=false -Tpng -o "${outDir}"'sfdp.png' "$dotFile";
}

processDotType(){
    dType="$1";

    find 'dotFiles/'"$dType" -name "*.dot" -or -name "*.gv" | while read -r dotFile; do
    if [[ ! -z "$dotFile" ]]; then
        processDotFile "$dotFile" "$dType";
        # echo "$dotFile";
    fi
done
}

processAllDotTypes(){
    echo "$dotTypes" | while read -r dType; do
    if [[ ! -z "$dType" ]]; then
        processDotType "$dType";
    fi
    done
}


processAllDotTypes
