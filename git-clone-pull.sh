#/usr/bin/bash

WORKDIR=/opt
REPO=$1
TARGET=/opt/$1/node_modules

reponame=$(echo $REPO | awk -F/ '{print $NF}' | sed 's/\.git$//')
if [ -d "$WORKDIR/$reponame" ]; then
        (cd $WORKDIR/$reponame ; git pull)
else
        git clone $1 "$WORKDIR/$reponame"
		cd $WORKDIR/$reponame && npm install 

fi

name=$(json name < $WORKDIR/$reponame/package.json)
newversion=$(json version < $WORKDIR/$reponame/package.json)
[ -f $TARGET/$name/package.json ] && oldversion=$(json version < $TARGET/$name/package.json)

[ "$newversion" \> "$oldversion" ] && npm install -g $WORKDIR/$reponame
exit 0
