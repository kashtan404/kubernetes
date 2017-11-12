#!/bin/bash
for file_path in $(find $1 -name \*.yaml); do
    if [[ $(find ${file_path} -mmin -3 -type f) == ${file_path} ]]; then
		if [[ $(find ${file_path} -mmin -3 -type f) == $(find ${file_path} -amin -3 -type f) ]]; then
			echo Created: ${file_path}
			kubectl create -f ${file_path}
		else
			echo Changed: ${file_path}
			kubectl replace -f ${file_path}
		fi
    else
		echo Uptodate: ${file_path}
    fi
done
exit 0