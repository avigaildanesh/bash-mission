if [ $# -lt 2 ]; then
    echo "Not enough parameters"
    exit 1
fi

# with r
if [ "$3" = "-r" ]; then 
        # find return list of files .out. the while loop gets from the find read
       find $1 -name '*.out' | while IFS= read -r line; do
        rm "$line"
        done
        # same
        aa=$(find $1 -name '*.c')
        # grep find words in files, word in $2 and the list of files in aa
        grep -i -l -w "$2" $aa | while IFS= read -r line; do 
        # compile and change
        gcc -w "$line" -o "${line/%c/out}"
        done
    else
    # without r
        find $1 -maxdepth 1 -name '*.out' | while IFS= read -r line; do
        rm "$line"
        done
        aa=$(find $1 -maxdepth 1 -name '*.c')
        # grep find words in files, word in $2 and the list of files in aa
        grep -i -l -w "$2" $aa | while IFS= read -r line; do 
        # compile and change
        gcc -w "$line" -o "${line/%c/out}"
        done
fi   
