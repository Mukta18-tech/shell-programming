#!/bin/bash
#16
# Ask for the input line
read -p "Enter a line: " line

# Ask what to replace the first 4 characters with
read -p "Enter replacement text (4+ chars recommended): " rep

# Split the line into an array
read -ra words <<< "$line"

# Check if at least 5 words are present
if [[ ${#words[@]} -ge 5 ]]; then
    word="${words[4]}"
    if [[ ${#word} -ge 4 ]]; then
        words[4]="$rep${word:4}"
    else
        words[4]="$rep"
    fi
    echo "Modified line: ${words[*]}"
else
    echo "The line has less than 5 words."
fi

#19
#!/bin/bash

# Ask for the username
read -p "Enter a username: " username
ls /home/| cat > alluser.txt
# Check in /etc/passwd if the user exists
if grep -w -q $username alluser.txt 
then
    echo "✅ $username is a valid user."
else
    echo "❌ $username is NOT a valid user."
fi

#20
if [ $# -ne 1];
then
    echo "privide username"
fi
cat / home /$1 /.bash_history/tail -n 20
#21
#!/bin/bash
# Script: greet.sh

hour=$(date +%H)

if [ $hour -ge 0 ] && [ $hour -lt 12 ]; then
    echo "GOOD MORNING"
elif [ $hour -ge 12 ] && [ $hour -lt 17 ]; then
    echo "GOOD AFTERNOON"
else
    echo "GOOD EVENING"
fi


#24
#!/bin/bash
# Script: rwx_files.sh

echo "Files in current directory with read, write, and execute permissions:"

# Using test -r -w -x for user permissions
for file in *; do
    if [ -f "$file" ] && [ -r "$file" ] && [ -w "$file" ] && [ -x "$file" ]; then
        echo "$file"
    fi
done
#27
#!/bin/bash
# Script: last14days.sh

dir="."
if [ $# -ge 1 ]; then
    dir=$1
fi

if [ ! -d "$dir" ]; then
    echo "Error: $dir is not a directory."
    exit 1
fi

echo "Files in '$dir' modified in the last 14 days:"
find "$dir" -type f -mtime -14 -ls

#!/bin/bash
# Script: november_pfiles.sh
#28
dir="."
if [ $# -ge 1 ]; then
    dir=$1
fi

if [ ! -d "$dir" ]; then
    echo "Error: $dir is not a directory."
    exit 1
fi

echo "Files in '$dir' (created/modified in November) starting with P or p:"

# Month 11 means November
find "$dir" -type f -name "[Pp]*" -newermt "2024-11-01" ! -newermt "2024-11-30" -ls

#old
if [ $# -ne 1];then
    echo "err:noarguments passed "
    exit 0
fi
if[ -e $1];then
    find $1 -printf '%Tm%P\n'|grep -w 08|awk '{ print $2 }' | xargs -r ls -l
    exit 1
else 

    echo "err:path does not exist"
    exit 0
fi
    
