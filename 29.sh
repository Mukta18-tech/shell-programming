#!/bin/bash
#29
# Initialize sum
total_size=0

echo "Non-directory files in current directory:"
echo "----------------------------------------"

# Loop through all items in the current directory
for file in *; do
    if [ -f "$file" ]; then  # Check if it is a regular file
        echo "$file"
        size=$(stat -c%s "$file")  # Get file size in bytes
        total_size=$((total_size + size))
    fi
done

echo "----------------------------------------"
echo "Total size of all non-directory files: $total_size bytes"

#30
echo "files starting with vowels in current directory:"
echo "----------------------------------------"

# Loop through all items in the current directory
for file in *; do
    if [ -f "$file" ] && [[ "$file" =~ ^[AEIOUaeiou] ]];
    then
        echo "$file"
    fi
done

#31
#!/bin/bash

# Check if exactly two arguments are passed
if [ $# -ne 2 ]; then
    echo "Usage: $0 <dir1> <dir2>"
    exit 1
fi

bar1="$1"
bar2="$2"

# Check if both are valid directories
if [ ! -d "$bar1" ] || [ ! -d "$bar2" ]; then
    echo "Error: Both arguments must be valid directories."
    exit 1
fi

# Loop through files in bar1
for file in "$bar1"/*; do
    filename=$(basename "$file")
    
    # Check if same-named file exists in bar2
    if [ -f "$bar2/$filename" ]; then
        echo "Deleting $bar2/$filename"
        rm "$bar2/$filename"
    fi
done

echo "Deletion completed."

#32
#!/bin/bash

# Read directory name from user
read -p "Enter directory name: " dir

# Check if directory exists
if [ ! -d "$dir" ]; then
    echo "Error: '$dir' is not a valid directory."
    exit 1
fi

# Count files in current directory (only regular files)
count_current=$(find . -maxdepth 1 -type f | wc -l)

# Count files in given directory (only regular files)
count_other=$(find "$dir" -maxdepth 1 -type f | wc -l)

echo "Current directory has $count_current files."
echo "'$dir' has $count_other files."

# Compare counts
if [ $count_current -gt $count_other ]; then
    diff=$((count_current - count_other))
    echo "Current directory has $diff more files than '$dir'."
elif [ $count_other -gt $count_current ]; then
    diff=$((count_other - count_current))
    echo "'$dir' has $diff more files than current directory."
else
    echo "Both directories have the same number of files."
fi
#35
#!/bin/bash

# Ask for file names
read -p "Enter first file name: " file1
read -p "Enter second file name: " file2
read -p "Enter name for the concatenated file: " output

# Check if files exist
if [ ! -f "$file1" ] || [ ! -f "$file2" ]; then
    echo "Error: One or both input files do not exist."
    exit 1
fi

# Concatenate files
cat "$file1" "$file2" > "$output"
echo "Files have been concatenated into '$output'."

# Count lines, words, characters
lines=$(wc -l < "$output")
words=$(wc -w < "$output")
chars=$(wc -m < "$output")

echo "Number of lines: $lines"
echo "Number of words: $words"
echo "Number of characters: $chars"
#36
#!/bin/bash

# Read file names
read -p "Enter first file name: " file1
read -p "Enter second file name: " file2

# Check if files exist
if [ ! -f "$file1" ] || [ ! -f "$file2" ]; then
    echo "Error: One or both files do not exist."
    exit 1
fi

# Compare files
if cmp -s "$file1" "$file2"; then
    echo "Files are duplicates. Deleting '$file2'..."
    rm "$file2"
else
    echo "Files are different. Concatenating..."
    cat "$file1" "$file2" > concatenated.txt
    echo "Files concatenated into 'concatenated.txt'."
fi
#!/bin/bash
#39
# Predefined password
PASSWORD="1234"

# Give the user 3 attempts
for attempt in 1 2 3
do
    echo -n "Enter password: "
    read -s user_pass
    echo
    if [ "$user_pass" == "$PASSWORD" ]; then
        echo "Access Granted!"

        while true
        do
            echo "---------------------------------"
            echo "Menu:"
            echo "1) Number of users currently logged in"
            echo "2) Current month (Windows safe)"
            echo "3) Current date (dd / mm / yyyy)"
            echo "4) Exit"
            echo "---------------------------------"
            read -p "Enter your choice [1-4]: " choice

            case $choice in
                1) 
                    # works in Git Bash / WSL
                    who 2>/dev/null | wc -l || echo "who not available on Windows"
                    ;;
                2) 
                    # Show current month instead of full calendar
                    date +"%B %Y"
                    ;;
                3) 
                    # dd / mm / yyyy format
                    date +"%d / %m / %Y"
                    ;;
                4) 
                    echo "Exiting..."
                    exit 0
                    ;;
                *) 
                    echo "Invalid choice! Try again."
                    ;;
            esac
        done
    else
        echo "Wrong password (Attempt $attempt of 3)"
    fi
done

echo "Access Denied. Too many wrong attempts."

