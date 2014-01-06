#!/bin/bash
# this script works with git bash.
# it allows you to create a zip of a tag or HEAD revision easily.
# usage is:
# ./gitarchive.sh Repo/Proj/..
#
# point this to whereever you are creating the zip archive
archFolder="/f/Archive"
cd $1
projname=`basename $1`
echo $projname
select tagname in "HEAD" `git tag -l | sort -r` 
do
echo 
read -p "You picked $tagname ok? [Y/n] " yesno
if [ "$yesno" != "n" ]
then
	break
else
	echo "Pick tag"
fi
done
if [ "$tagname" = "HEAD" ]
then
	d="."`date "+%Y%m%d"`
else
	d=""
fi
archname=${projname}_${tagname}
tmparchname=$archname
i=1

while [ -f "$archFolder/$tmparchname$d.zip" ]
do
	tmparchname="$archname.$i"
	i=$(( i + 1 ))
done
archname=$tmparchname
echo $archFolder/$archname

git archive --prefix="$archname$d/" -o "$archFolder/$archname$d.zip" $tagname^{tree}
