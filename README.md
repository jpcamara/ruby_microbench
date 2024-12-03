# Rubo Microbench

A repo for building microbenchmarks to compare Ruby performance against different Ruby versions and interpreters.

This project is built off the excellent https://github.com/bddicken/languages, a repo for collaboratively building small benchmarks to compare languages.

## Running

At the moment, versions of Ruby are loaded and run by `rbenv`.

The benchmarks are run with the `run.sh` script. By default all benchmarks will run for all Ruby versions:

1. Run via `$ bash ./run.sh`.
  You should see output something like:
  
  ```
  $ bash ./run.sh
  Running fibonacci...
  ruby 3.4.0dev
  ruby ./code.rb 40

  Ruby 3.4 = 16.44s
  Ruby 3.4 = 16.53s
  Ruby 3.4 = 16.52s

  ruby 3.4.0dev
  ruby --yjit ./code.rb 40

  Ruby 3.4 YJIT = 2.20s
  Ruby 3.4 YJIT = 2.23s
  Ruby 3.4 YJIT = 2.20s

  ruby 3.3.6
  ruby ./code.rb 40

  Ruby 3.3 = 16.37s
  ...
  ```
2. If you want to filter down to a specific benchmark, you can run `$ bash ./run.sh fibonacci`.
3. If you want to filter down to a particular ruby version/implementation, you can run `$ bash ./run.sh "" 3.4.0dev`.
4. You can combine the filters to run a particular benchmark for a particular ruby using `$ bash ./run.sh fibonacci 3.4.0dev`.

### Interpretation

The numbers represent the real execution time (wall-clock time) it took for each ruby version to execute the given task. **A lower number indicates better performance.**

`bash ./run.sh` runs each program three times using the `runOnce` function and `awk` captures the real execution time.

## Adding

1. To add a new Ruby implementation, add an appropriate line to `./run.sh`. For example, to add a fictional Ruby called Ruby Roo, you would add:

  ```
  "Ruby Roo|RBENV_VERSION=roo-dev|ruby"
  ```
2. To add a new code example, add a folder to the project with a `code.rb` file. Then update the folder declaration:

  ```
  declare -a folders=("fibonacci" "loop_array_each" "loop_range_each" "loop_times" "new_benchmark")
  ```

# Available Benchmarks

## loops

Emphasizes loop, conditional, and basic math performance.

## fibonacci

Emphasizes function call overhead and recursion.
