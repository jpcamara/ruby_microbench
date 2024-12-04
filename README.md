# Rubo Microbench

This repo is forked from https://github.com/bddicken/languages, a "repo for collaboratively building small benchmarks to compare languages".

I forked it as part of writing [Speeding up Ruby by rewriting C... in Ruby](https://jpcamara.com/2024/12/01/speeding-up-ruby.html). It let me experiment with different loop combinations to better understand how they would impact CRuby and YJIT.

Out of curiosity, I expanded it to Ruby 3.4, 3.3 and 3.2, as well as a few other Ruby flavors (TruffleRuby, Artichoke, MRuby).

_These benchmarks are meaningless for real applications_. *_But_*, they did give me a way to see what limits were I could push YJIT on, expanding what was possible in the original "languages" repo. Here are some of the numbers I got for the fibonacci run on my M2 Macbook Air:

<table>
<thead>
<tr>
<th></th>
<th>fibonacci</th>
<th>
array#each
</th>
<th>range#each</th>
<th>times</th>
<th>for</th>
<th>while</th>
<th>loop do</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ruby 3.4 YJIT</td><td>2.19s</td>
<td>14.02s</td>
<td>26.61s</td>
<td>13.12s</td>
<td>27.38s</td>
<td>37.10s</td>
<td>13.95s</td></tr>
<tr>
<td>Ruby 3.4</td>
<td>16.49s</td>
<td>34.29s</td><td>33.88s</td>
<td>33.18s</td>
<td>36.32s</td>
<td>37.14s</td>
<td>50.65s</td>
</tr>
<tr><td>TruffleRuby 24.1</td><td>0.92s</td>
<td>0.97s</td>
<td>0.92s</td><td>2.39s</td>
<td>2.06s</td><td>3.90s</td>
<td>0.77s</td>
</tr><tr>
<td>MRuby 3.3</td>
<td>28.83s</td>
<td>144.65s</td>
<td>126.40s</td>
<td>128.22s</td>
<td>133.58s</td><td>91.55s</td>
<td>144.93s</td>
</tr>
<tr>
<td>Artichoke</td>
<td>19.71s</td>
<td>236.10s</td><td>214.55s</td>
<td>214.51s</td>
<td>215.95s</td>
<td>174.70s</td>
<td>264.67s</td>
</tr>
</tbody>
</table>

The numbers may not have practical meaning, but _dang_, TruffleRuby blazed through it.

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
