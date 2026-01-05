orgFile="vencord-simplicity.css"
buildOutput="vencord-simplicity-final.css"

imports=$(cat "$orgFile" | grep -Eo "@import.*;")
files=$(echo "$imports" | grep -Po "(?<=\")(.*)(?=\")")


rm "$buildOutput"
touch "$buildOutput"

# Append all imported CSS files
for file in $files; do
    echo "/* ===== $(basename "$file") ===== */" >> "$buildOutput"
    echo "" >> "$buildOutput"
    cat "$file" >> "$buildOutput"
    echo "" >> "$buildOutput"
done

# Append original file and remove all @import lines
echo "" >> "$buildOutput"
echo "/* ===== $(basename "$orgFile") ===== */" >> "$buildOutput"
echo "" >> "$buildOutput"
cat "$orgFile" | sed "/^@import.*/c\\" >> "$buildOutput"