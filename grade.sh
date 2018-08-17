#!/bin/sh

EXPECTED_FILES="src"

DIFF_TOOLS=gs-diff-based-testing

# YOU SHOULD NOT NEED TO EDIT BELOW THIS POINT.

echo $EXPECTED_FILES

if [ -d $DIFF_TOOLS ]; then
  cd $DIFF_TOOLS
  git pull origin master
  cd ..
else
  git clone https://github.com/ucsb-gradescope-tools/${DIFF_TOOLS}.git
fi


if [ "$#" -eq 1 ]; then
    SUBMISSION_SOURCE=`pwd`/$1
else
    SUBMISSION_SOURCE=/autograder/submission
fi

if [ -d $SUBMISSION_SOURCE ]; then  
   echo "Checking submission from $SUBMISSION_SOURCE"
else
   echo "ERROR: $SUBMISSION_SOURCE does not exist"
   exit
fi

copy_files_from_dir_if_it_exists () {
    if [ -d $1 ]; then
        cp -rv $1/* .
    fi
}

/bin/rm -rf MAKE-STUDENT-OUTPUT
mkdir -p MAKE-STUDENT-OUTPUT

cd MAKE-STUDENT-OUTPUT

copy_files_from_dir_if_it_exists ../EXECUTION-FILES
copy_files_from_dir_if_it_exists ../BUILD-FILES

for f in $EXPECTED_FILES; do
    if [ -f $SUBMISSION_SOURCE/$f ]; then
	echo "Copying $f to ."
        cp -v $SUBMISSION_SOURCE/$f .
    elif [ -d $SUBMISSION_SOURCE/$f ]; then
	echo "Rsync'ing $f to ."
        rsync -trv $SUBMISSION_SOURCE/$f .
    else
        echo "WARNING: Expected file $f not found in $SUBMISSION_SOURCE"
    fi
done


/bin/rm -fv *-results.json
/bin/rm -fv results.json

../${DIFF_TOOLS}/grade-diffs.py ../diffs.sh -o diff-results.json

# NOW DO THE UNIT TEST STUFF

../unittest.sh   # this writes to ./unittest-results.json

# NOW COMBINE THE FILES AND COPY TO FINAL LOCATION

../${DIFF_TOOLS}/combine-results-json.py *-results.json -o results.json

if [ -d /autograder/results ]; then
    cp -v results.json /autograder/results/results.json
fi

cd ..
