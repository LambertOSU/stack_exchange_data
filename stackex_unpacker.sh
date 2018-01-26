#!

# this script unpacks the 7zip files
# into appropriately named directories

# loop through all the .7z files
for file in ./*.7z;
do
  # get the community name
  name="${file#*/}"
  name="${name%%.*}"

  # make the directory
  mkdir ./"$name"

  # unzip the file
  7z e "$file" -o./"$name"

done
