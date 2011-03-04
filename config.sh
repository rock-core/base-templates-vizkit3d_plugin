#!/bin/sh

# Author: Alexander Duda, Thomas Roehr, thomas.roehr@dfki.de, Sylvain Joyeux
# This script sets up a git repository based on an existing template project

#Check for name of project
# Extract directory for config.sh
SCRIPT_DIR=`dirname $O`
DIR=`dirname $0`
cd $DIR
DIR=`pwd`
# Extract Projectname
PACKAGE_DIR_NAME=`dirname $DIR`
PACKAGE_DIR_NAME=`basename $PACKAGE_DIR_NAME`

usage() {
    echo "usage: $0"
    echo "This script sets up a vizkit plugin insdde an already existing"
    echo "cmake package. It requests required information from the user when needed."
}

apply_template_value() {
    name=$1
    value=$2
    find . -type f -exec sed -i "s/$name/$value/g" {} \;
    find . -type f -name "*$name*" | while read path; do
        newpath=`echo $path | sed "s/$name/$value/g"`
        mv $path $newpath
    done
}

# If no arguments are given or help is requested
if [ "$1" = "-h" ] || [ "$1" = "--help" ]
	then usage
	exit 0
fi

if [ "$1" != "" ]; then
	usage
        exit 1
else
	PACKAGE_SHORT_NAME=$PACKAGE_DIR_NAME
fi

echo "Do you want to start the configuration of the vizkit plugin for project ${PACKAGE_SHORT_NAME}"

# Check and interprete answer of "Proceed [y|n]"
ANSWER=""
until [ "$ANSWER" = "y" ] || [ "$ANSWER" = "n" ] 
do
	echo "Proceed [y|n]"
	read ANSWER
	ANSWER=`echo $ANSWER | tr "[:upper:]" "[:lower:]"`
done

if [ "$ANSWER" = "n" ]
	then echo "Aborted."
	exit 0
fi

# Change into the operation directory
cd $DIR

# Select package type
PACKAGE_TYPE="CMAKE"

# CMAKE-TEMPLATE-ADAPTION
if [ $PACKAGE_TYPE = "CMAKE" ]; then
	# removing git references to prepare for new check in
	rm -rf .git

	echo "------------------------------------------"
	echo "We require some information to create the plugin"
	echo "------------------------------------------"
        echo "a VizKit plugin is essentially a class that is designed"
        echo "to display a certain data type (= C++ class / structure)"
        echo "on a vizkit widget"
        echo
        echo "What should be the class name ? (Press ENTER when finished)"
        echo "This should be a simple name as PathVisualization, with no"
        echo "namespaces. The generated class will be put in the vizkit"
        echo "namespace"
	read CLASS_NAME
        if test -z "$CLASS_NAME"; then
            echo "the class name cannot be empty"
            exit 1
        elif ( echo $CLASS_NAME | grep -q ':' ); then
            echo "the class name cannot contain namespace specification"
            exit 1
        fi
        echo "What is the type that you want to display ? (Press ENTER when finished)"
        echo "Please give the full type (i.e. with namespace) as e.g.  base::Time"
	read TYPE_NAME
        if test -z "$TYPE_NAME"; then
            echo "the type name cannot be empty"
        fi

        apply_template_value projectname $PACKAGE_SHORT_NAME
        apply_template_value classname $CLASS_NAME
        apply_template_value typename $TYPE_NAME
fi
# end of CMAKE-TEMPLATE-ADAPTION

#delete setup script
rm config.sh

git add .
git commit -m "initial vizkit plugin code"

echo "Done."

