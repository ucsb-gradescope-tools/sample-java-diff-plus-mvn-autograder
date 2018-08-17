#!/usr/bin/env bash

echo "This script will make the reference output"
echo "Downloading the Gradescope gs-diff-based-testing tools"

copy_files_from_dir_if_it_exists () {

    if [ -d $1 ]; then
	for f in $1/*; do
	    if [ -f $f ]; then
		echo "Copying $f to ."
		cp -v $f .
	    elif [ -d $f ]; then
		echo "Rsync'ing $f to ."
		rsync -trv $f .
	    else
		echo "WARNING: THIS SHOULD NOT HAPPEN... \$f=$f \$1=$1"
	    fi
	done
    fi

}

git clone https://github.com/ucsb-gradescope-tools/gs-diff-based-testing.git
cd gs-diff-based-testing
git pull origin master
cd ..
pip3 install jsonschema

DIFF_TOOLS=../gs-diff-based-testing

/bin/rm -rf MAKE-REFERENCE-OUTPUT 
mkdir -p MAKE-REFERENCE-OUTPUT

cd MAKE-REFERENCE-OUTPUT

copy_files_from_dir_if_it_exists ../REFERENCE-SOLUTION
copy_files_from_dir_if_it_exists ../EXECUTION-FILES
copy_files_from_dir_if_it_exists ../BUILD-FILES

${DIFF_TOOLS}/grade-diffs.py -r ../diffs.sh 
