#/usr/bin/bash

export HOME=/root
WORKDIR=/root/git
REPO=$1
TARGET=/opt/local/lib/node_modules

reponame=$(echo $REPO | awk -F/ '{print $NF}' | sed 's/\.git$//')
mkdir -p $WORKDIR
if [ -d "$WORKDIR/$reponame" ]; then
	(cd $WORKDIR/$reponame ; git pull)
else
	git clone $1 "$WORKDIR/$reponame"
fi

name=$(json name < $WORKDIR/$reponame/package.json)
newversion=$(json version < $WORKDIR/$reponame/package.json)
[ -f $TARGET/$name/package.json ] && oldversion=$(json version < $TARGET/$name/package.json)

[ "$newversion" \> "$oldversion" ] && npm install -g $WORKDIR/$reponame
