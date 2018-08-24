# sample-java-diff-plus-mvn-autograder

This is a sample autograder for a Javan assignment that uses both diff based testing and mvn JUnit based testing.

# Platform specific notes

## Windows

Editing bash scripts (e.g. `diffs.sh`) on Windows will convert the line endings to Windows style, causing the script to be unusable by the Docker container. Either edit the files in a Unix/Mac environment or use a tool to de-convert the line endings BEFORE uploading your autograder.zip.**

# Components

## EXECUTION-FILES

Any extra files (e.g. data files) that should be in the same directory as the student submission while the submission is being executed.    If there is an instructor supplied build.xml, instructor supplied test cases, etc. those should go here.


## REFERENCE-SOLUTION

A reference solution which will be used to generate the expected outcome for all tests. Like student solutions, this solution will be run with all files from EXECUTION-FILES in the same directory.

## MAKE-REFERENCE<i></i>.sh

A bash script that creates the expected test output using the reference solution. **Leave this unchanged when creating your own autograder.**

## `apt-get.sh`
A bash script for installing any necessary dependencies for the assignment.

## requirements3<i></i>.txt
A list (newline-separated) of any **Python 3** packages that need to be installed.

## diffs<i></i>.sh

A bash script describing the tests to be run. See [this page](https://github.com/ucsb-gradescope-tools/gs-diff-based-testing/blob/master/README.md) for further documentation, especially [this handy reference to the annotations](https://github.com/ucsb-gradescope-tools/gs-diff-based-testing/blob/master/README.md#reference)

## grade<i></i>.sh

A bash script for generating the results of the student submission. At the top of this file, you must specify the expected student submisson files. 

> EXPECTED_FILES="Assignment.java Hello.java"

# Instructions

## Step 1: Clone this template

* Create a new empty private repo, e.g. with the name PRIVATE-cs56-m18-labxx-gs
* Clone the empty repo with `git clone <url>`
*  `cd` into that directory:
   > `cd PRIVATE-cs56-m18-labxx-gs`
* Add a remote for this sample repo via: 
   > `git remote add template git@github.com:ucsb-gradescope-tools/sample-java-diff-mvn-autograder.git`
* Pull from this sample repo via `git pull template master`
* Push to origin with `git push origin master`

## Step 2: Edit the template for your assignment (required)

* In `grade.sh` edit the environment variable `EXPECTED_FILES` to list the files you expect the student to submit.  Only these
   will be copied from the student submission into the space where the assignment is graded.
   
   If you prefer *all* files to be copied in, edit the `grade.sh` script to copy all files from `/autograder/submission` into
   the target directory.
   
* Edit the `diffs.sh` file to put in the tests that you want to run, along with shell script comments
   containing JSON indicating the tests.  [Handy reference to the annotations](https://github.com/ucsb-gradescope-tools/gs-diff-based-testing/blob/master/README.md#reference)

* Put a reference solution into REFERENCE-SOLUTION

### Hints

This emacs query-replace-regexp may be useful:

```
OLD: public void test_\([^{]+\){ 
NEW: @GradedTest(name="\1", max_score=1)^J     public void test_\1 {)
```

## TODO: ADD STEPS FOR THE JUNIT GRADING HERE

## Step 4: Test your autograder locally (optional)

To test your autograder locally:

Try putting a correct sample solution in the SAMPLE-SOLUTION-1 directory and an incorrect sample solution in the SAMPLE-SOLUTION-2 directory.  (You have the option of creating additional SAMPLE-SOLUTION-nn directories, as few or as many as you see fit if you want to test a wider range of solution possibilities.)

To check what will happen, run:
* First, run `./MAKE-REFERENCE.sh` to generate the output of the reference solution
* Then try grading each of your sample solutions:
   * `./grade.sh SAMPLE-SOLUTION-1`
   * `./grade.sh SAMPLE-SOLUTION-2` 
   * etc.

(When converting assignments from UCSB's submit.cs, you might adapt a "perfect" solution and a "flawed" solution from among previous student submissions, by looking at the grade assigned by submit.cs)

In each case, look at the file `results.json` to see whether it reflects what you expect the resulting grade to be.   

## Step 4: Create an `Autograder.zip` using the [link-gs-zip-with-repo](https://github.com/ucsb-gradescope-tools/link-gs-zip-with-repo) tool.
   
* Clone the [link-gs-zip-with-repo](https://github.com/ucsb-gradescope-tools/link-gs-zip-with-repo).
* In that repo, edit `env.sh` to point to your repo.  You don't need to commit that change.
* Run the script `./make_deploy_keys.sh` 
* **Upload your deploy key** to the new repo you created for your assignment.
* Run the script `./make_autograder_zip.sh` and then upload the `Autograder.zip` to Gradescope.

You are now ready to test your autograded assignment.
   

