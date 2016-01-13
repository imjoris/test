#!/bin/bash

name='report'
outputDir='myBuild'

MAKEPDFOPTS='openpdf'


##############################
## PARAMETERS
##############################

#Set them if supplied
if [[ ! -z $1 ]]; then
    name=$1;
fi
if [[ ! -z $2 ]]; then
    outputDir=$2;
fi

##############################
## Set options
##############################
mkdir -p ${outputDir}

dateNow="date +%m-%d__%H:%M"
outputName="${name}_$(eval $dateNow)"

latexInBuildDir="-output-directory=${outputDir}"
mycmd="texfot 'pdflatex -interaction=nonstopmode -output-directory=${outputDir} $name'"


doMakePdf(){
##############################
## EXECUTE COMMANDS
##############################
eval $mycmd | 2>&1
\rm ./${outputDir}/library.bib
\cp ./library.bib ${outputDir}
(cd ${outputDir}; bibtex -terse $name;);
(cd ${outputDir}; makeglossaries $name;);
eval $mycmd | 2>&1
eval $mycmd
(cd ${outputDir}; cp "${name}.pdf" "${outputName}.pdf");

}

doMakePdf $1 $2

#| grep ".*:[0-9]*:.*" | grep -v "Unescaped";
# grep -i ".*:[0-9]*:.*\|warning"
# grep -i ".*:[0-9]*:.*\|error"

if [[ "$MAKEPDFOPTS" -eq 'openpdf' ]]; then
    xdg-open ./"$outputDir"/"$outputName".pdf
fi
