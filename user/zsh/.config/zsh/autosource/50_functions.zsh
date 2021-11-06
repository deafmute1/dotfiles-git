funcs() {
    # Usage: funcs <command>
    # Commands: 
    #       names (or no command): Returns all function names defined in functions.zsh
    #       full: Returns functions.zsh verbatim   
    #       edit: Opens the functions file in vim
    #       <name>: Returns the full definition of function <name> in functions.zsh
    # Requires: coreutils 
    functions_=~/.config/zsh/50_functions.zsh
    if [[ "${(L)1}" == "names" ]] || [[ ! "$1"  ]]; then 
        grep -E "^[^[:space:]}#]" "$functions_" | grep -E "^[a-zA-Z_][a-zA-Z0-9_]*" | sed 's/() {//'
    elif [[ "${(L)1}" == "full" ]]; then 
        cat "$functions_"
    elif [[ "${(L)1}" == "edit" ]]; then
        vim "$functions_"
    else
        LNstart=$(grep -En "^[^[:space:]}#]" $functions_ | grep -E "^[0-9]*: *${1} *\(\) *{ *$" | cut -d: -f1)
        LNend=$(( $(tail -n "+${LNstart}" $functions_ | grep -Fxn "}" | head -n 1 |  cut -d: -f1) + $LNstart - 1)) 
        sed -n "${LNstart},${LNend}p;$(( $LNend + 1 ))q" $functions_
    fi
}

wget-list() { 
    # Usage: wget-list <file name>
    # Returns: wgets from a list formatted on each line as such: <url> <name of output file>
    # Requires: wget    
    err=0
    while read -r url filename tail; do
        wget -O "$filename" "$url" || err=1
    done < $1
}

create-gif() { 
    # Usage: create-gif <start time in seconds> <length of gifs in seconds> <input file> <output file>
    # Returns: A gif at <output file>
    # Requires: ffmpeg
    ffmpeg -ss $1 -t $2 -i $3 -vf "fps=10,scale=320:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -c copy -map 0 -loop 0 $4 
}

host-file() {
  # Usage: host-file <file name> OR <data stream> | host-file 
  # Options: 
  # -f <upload as filename> 
  f="$1" 
  shift 1
  up_name="" 
  while [[ "$#" -gt 0 ]]; do
    case "$1" in
      -f) up_name="$2"; shift 2 ;; 
    esac  
  done
  url=$(curl --silent --upload-file "$f" "https://up.ayew.host/upload/${up_name}")
  dir_url="https://up.ayew.host/direct/$(basename "$url")" 
  echo "$dir_url"
  echo "$dir_url" | wl-copy  
}

print-names() {
  # Usage: print_names <directory> <pattern> <ext>
  # Returns basenames in <directory> matching <pattern>, without some extension, <ext>
  find "$1" -name "$2" -exec basename "{}" "$3" \; | sort 
}

mime-type() {
  # Usage: mime-type <path to file>
  # Returns: files mime-type
  file --mime-type "$1" | awk '{print $2}'
}

path() { 
  realpath "$1" | wl-copy -selection clipboard 
}

ripsed() {
  # uses ripgrep (rg) as a sed replacement (find and replace) 
  # Replaces occurances of pattern $1 with string $2 in cwd/. 
  # for subfolder depth $3. 
  while IFS= read -r -d '' file; do 
    rg -P --passthru '$1' -r "$2" "$file" | sponge "$file" {} \; 
  done < <(find . -type f --maxdepth "$3")  
}

# Git stuff
git-bigf() { 
    # Usage: git-bigf <file size>
    # Returns: All files in current working git repo over <file size>
    # Requires: coreutils git
    min_size=$(( $1 / 1048576 )) 
    git rev-list --objects --all |
        git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' |
        sed -n 's/^blob //p' |
        awk '$2 >= $min_size' |
        sort --numeric-sort --key=2 |
        cut -c 1-12,41- |
        $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
}

cloc-remote-git() {
    # Usage: cloc-git <url to git remote>
    # Returns: Lines of code in git repo, with a minimal clone prodcedure to save time on remote repos
    # Requires: git, cloc
    git clone --depth 1 "$1" temp-linecount-repo &&
        printf "('temp-linecount-repo' will be deleted automatically)\n\n\n" &&
        cloc temp-linecount-repo &&
        rm -rf temp-linecount-repo
}

ranger-cd() {
    temp_file="$(mktemp -t "ranger_cd.XXXXXXXXXX")"
    ranger --choosedir="$temp_file" -- "${@:-$PWD}"
    if chosen_dir="$(cat -- "$temp_file")" && [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
        cd -- "$chosen_dir"
    fi
    rm -f -- "$temp_file"
}

count-extensions() { 
  find "$1" -type f | grep -E ".*\.[a-zA-Z0-9]*$" | sed -e 's/.*\(\.[a-zA-Z0-9]*\)$/\1/' | sort | uniq -c | sort -n
}

