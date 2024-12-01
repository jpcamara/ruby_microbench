# You need to export your JAVA_HOME to run JRuby
# export JAVA_HOME=

function runOnce  {
  { /usr/bin/time $2 ; } 2> /tmp/o 1> /dev/null
  printf "$1 = "
  cat /tmp/o | awk -v N=1 '{print $N"s"}'
}

function run {
  echo ""
  runOnce "$1" "$2"
  runOnce "$1" "$2"
  runOnce "$1" "$2"
}

echo "Running fibonacci..."
cd fibonacci
run "Ruby 3.4" "rvm ruby-head do ruby ./code.rb 40"
run "Ruby 3.4 YJIT" "rvm ruby-head do ruby --yjit ./code.rb 40"
run "Ruby 3.3" "rvm ruby-3.3.6 do ruby ./code.rb 40"
run "Ruby 3.3 YJIT" "rvm ruby-3.3.6 do ruby --yjit ./code.rb 40"
run "Ruby 3.2" "rvm ruby-3.2.5 do ruby ./code.rb 40"
run "Ruby 3.2 YJIT" "rvm ruby-3.2.5 do ruby --yjit ./code.rb 40"
run "TruffleRuby 24.1" "rvm truffleruby-24.1.1 do ruby ./code.rb 40"
run "JRuby 9.4.9" "rvm jruby-9.4.9.0 do ruby ./code.rb 40"
run "MRuby" "mruby ./code.rb 40"
# run "NatalieRuby" "natalie ./code.rb 40"
cd ..

echo "Running loop_array_each..."
cd loop_array_each
run "Ruby 3.4" "rvm ruby-head do ruby ./code.rb 40"
run "Ruby 3.4 YJIT" "rvm ruby-head do ruby --yjit ./code.rb 40"
run "Ruby 3.3" "rvm ruby-3.3.6 do ruby ./code.rb 40"
run "Ruby 3.3 YJIT" "rvm ruby-3.3.6 do ruby --yjit ./code.rb 40"
run "Ruby 3.2" "rvm ruby-3.2.5 do ruby ./code.rb 40"
run "Ruby 3.2 YJIT" "rvm ruby-3.2.5 do ruby --yjit ./code.rb 40"
run "TruffleRuby 24.1" "rvm truffleruby-24.1.1 do ruby ./code.rb 40"
run "JRuby 9.4.9" "rvm jruby-9.4.9.0 do ruby ./code.rb 40"
run "MRuby" "mruby ./code.rb 40"
# run "NatalieRuby" "natalie ./code.rb 40"
cd ..

echo "Running loop_range_each..."
cd loop_range_each
run "Ruby 3.4" "rvm ruby-head do ruby ./code.rb 40"
run "Ruby 3.4 YJIT" "rvm ruby-head do ruby --yjit ./code.rb 40"
run "Ruby 3.3" "rvm ruby-3.3.6 do ruby ./code.rb 40"
run "Ruby 3.3 YJIT" "rvm ruby-3.3.6 do ruby --yjit ./code.rb 40"
run "Ruby 3.2" "rvm ruby-3.2.5 do ruby ./code.rb 40"
run "Ruby 3.2 YJIT" "rvm ruby-3.2.5 do ruby --yjit ./code.rb 40"
run "TruffleRuby 24.1" "rvm truffleruby-24.1.1 do ruby ./code.rb 40"
run "JRuby 9.4.9" "rvm jruby-9.4.9.0 do ruby ./code.rb 40"
run "MRuby" "mruby ./code.rb 40"
# run "NatalieRuby" "natalie ./code.rb 40"
cd ..

echo "Running loop_times..."
cd loop_times
run "Ruby 3.4" "rvm ruby-head do ruby ./code.rb 40"
run "Ruby 3.4 YJIT" "rvm ruby-head do ruby --yjit ./code.rb 40"
run "Ruby 3.3" "rvm ruby-3.3.6 do ruby ./code.rb 40"
run "Ruby 3.3 YJIT" "rvm ruby-3.3.6 do ruby --yjit ./code.rb 40"
run "Ruby 3.2" "rvm ruby-3.2.5 do ruby ./code.rb 40"
run "Ruby 3.2 YJIT" "rvm ruby-3.2.5 do ruby --yjit ./code.rb 40"
run "TruffleRuby 24.1" "rvm truffleruby-24.1.1 do ruby ./code.rb 40"
run "JRuby 9.4.9" "rvm jruby-9.4.9.0 do ruby ./code.rb 40"
run "MRuby" "mruby ./code.rb 40"
# run "NatalieRuby" "natalie ./code.rb 40"
cd ..