#!/bin/bash

#
# add extern git command
#
do_extern_git() {
	git branch --set-upstream  master  origin/master
	git branch --set-upstream  zjhn  origin/zjhn
	
	# about zjhn	
	git checkout zjhn
	
	# about master
	#git checkout master
        
	#git branch -v
	git pull
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
		do_extern_git
		print_line leave ${docs}
		cd - > /dev/null
		sleep 2
	done < ${tmp}
	rm ${tmp}
}
main "$@"
