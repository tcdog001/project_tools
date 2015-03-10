#!/bin/bash

#
# add extern git command
# $1: doc
#
do_extern_git() {
	local doc=$1
	git branch --set-upstream  master  origin/master
	git branch --set-upstream  zjhn  origin/zjhn
	
	if [ "${doc}" != "website" ]; then
	# about zjhn	
	git checkout zjhn
	
	# about master
	#git checkout master
	else
		# when doc is website
		git checkout master
        fi
        
	#git branch -v
	git pull
	#git push
	#git tag -a v1.0.6.8 -m "version 1.0.6.8: about User Authentication for zjhn"
	#git push --tag
}

do_normal_git() {
	git status .
}

#
# print line of '\='
#
print_line() {
	echo "====================$*======================"
}

main() {
	local file=list.in
	local tmp=${file}.tmp
	local docs

	sed '/#/d;/^$/d' ${file}> ${tmp}
	echo "--document list--"
	cat ${tmp}
	
	while read docs; do
		cd ${docs}
		print_line enter ${docs}
		do_normal_git
		do_extern_git ${docs}
		print_line leave ${docs}
		cd - > /dev/null
		sleep 2
	done < ${tmp}
	rm ${tmp}
}
main "$@"
