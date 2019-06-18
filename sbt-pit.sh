#!/usr/bin/env bash

# Usage ./sbt-pit.sh scalaj-http-master "scala.http.*"

# Project specific parameters
# Change to match your project
PROJECT_DIR=$1
TARGET_CLASSES=$2



# Getting the absolute path of the project
pushd . >> /dev/null
cd $PROJECT_DIR
PROJECT_DIR=`pwd`
popd >> /dev/null

# These might change depending on the project
CLASSES=$PROJECT_DIR/target/scala-2.12/classes
TEST_CLASSES=$PROJECT_DIR/target/scala-2.12/test-classes
SOURCES=$PROJECT_DIR/src/main/scala/,$PROJECT_DIR/src/test/scala

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

IVY2_CACHE=$HOME/.ivy2/cache

cd $PROJECT_DIR
SCP=$(sbt printTestClasspath | grep -vE "\[")
SCP=\
$SCP:\
$SCRIPT_DIR/bin/pitest-command-line-1.4.8.jar:\
$SCRIPT_DIR/bin/pitest-1.4.8.jar:\
$SCRIPT_DIR/bin/pitest-entry-1.4.8.jar:\
$SCRIPT_DIR/bin/j2html-1.3.0.jar:\
$SCRIPT_DIR/bin/descartes-1.2.6-SNAPSHOT.jar

java -cp "$SCP" org.pitest.mutationtest.commandline.MutationCoverageReport \
--reportDir $PROJECT_DIR \
--targetClasses $TARGET_CLASSES \
--verbose true \
--outputFormats JSON,ISSUES,METHODS \
--failWhenNoMutations off \
--classPath $CLASSES,$TARGET_CLASSES \
--mutableCodePath $CLASSES \
--sourceDirs $SOURCES \
--mutationEngine descartes
