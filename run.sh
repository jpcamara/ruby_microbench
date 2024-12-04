# You need to export your JAVA_HOME to run JRuby
export JAVA_HOME=

# Add these at the top after JAVA_HOME
folder_filter=$1
version_filter=$2

function runOnce  {
  { /usr/bin/time $3 ; } 2> /tmp/o 1> /dev/null
  printf "$1 = "
  cat /tmp/o | awk -v N=1 '{print $N"s"}'
}

function run {
  export $2
  if [[ "$2" == *"artichoke"* ]]; then
    { ruby --version; }
  else
    { ruby -v; }
  fi
  echo "$3 \n"
  runOnce "$1" "$2" "$3"
  runOnce "$1" "$2" "$3"
  runOnce "$1" "$2" "$3"
  printf "\n"
}

# Define all Ruby versions to test
declare -a ruby_versions=(
  "Ruby 3.4|RBENV_VERSION=3.4-dev|ruby"
  "Ruby 3.4 YJIT|RBENV_VERSION=3.4-dev|ruby --yjit"
  "Ruby 3.3|RBENV_VERSION=3.3.6|ruby"
  "Ruby 3.3 YJIT|RBENV_VERSION=3.3.6|ruby --yjit"
  "Ruby 3.2|RBENV_VERSION=3.2.5|ruby"
  "Ruby 3.2 YJIT|RBENV_VERSION=3.2.5|ruby --yjit"
  "TruffleRuby 24.1|RBENV_VERSION=truffleruby-24.1.1|ruby"
  # "JRuby 9.4.9|RBENV_VERSION=jruby-9.4.9.0|ruby -Xcompile.invokedynamic=true"
  "Ruby Artichoke|RBENV_VERSION=artichoke-dev|ruby"
  "MRuby|RBENV_VERSION=mruby-3.3.0|ruby"
  # "NatalieRuby|NONE|natalie"
)

# Define folders to test
declare -a folders=("fibonacci" "loop_array_each" "loop_range_each" "loop_times" "loop_for" "loop_while" "loop_do")

# Loop through each folder
for folder in "${folders[@]}"; do
  # Skip if folder filter is set and doesn't match
  if [ ! -z "$folder_filter" ] && [ "$folder" != "$folder_filter" ]; then
    continue
  fi
  
  echo "Running $folder..."
  cd "$folder"
  
  # Loop through each Ruby version
  for version in "${ruby_versions[@]}"; do
    IFS='|' read -r name env cmd <<< "$version"
    # Skip if version filter is set and doesn't match
    if [ ! -z "$version_filter" ] && [[ "$env" != *"$version_filter"* ]]; then
      continue
    fi
    
    if [[ "$env" == "NONE" ]]; then
      run "$name" "" "$cmd ./code.rb 30"
    else
      run "$name" "$env" "$cmd ./code.rb 40"
    fi
  done
  
  cd ..
done