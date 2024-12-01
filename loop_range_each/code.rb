u = ARGV[0].to_i                              # Get an input number from the command line
r = rand(10000)                               # Get a random number 0 <= r < 10k
a = Array.new(10000, 0)                       # Array of 10k elements initialized to 0

(0...10000).each do |i|                       # 10k outer loop iterations
  (0...100000).each do |j|                    # 100k inner loop iterations, per outer loop iteration
    a[i] += j % u                             # Simple sum
  end
  a[i] += r                                   # Add a random value to each element in array
end

puts a[r]                                     # Print out a single element from the array

# Running loop_range_each...

# Ruby 3.4 = 34.24s
# Ruby 3.4 = 34.34s
# Ruby 3.4 = 34.56s

# Ruby 3.4 YJIT = 26.90s
# Ruby 3.4 YJIT = 30.99s
# Ruby 3.4 YJIT = 26.96s

# Ruby 3.3 = 33.73s
# Ruby 3.3 = 34.19s
# Ruby 3.3 = 33.65s

# Ruby 3.3 YJIT = 31.33s
# Ruby 3.3 YJIT = 25.73s
# Ruby 3.3 YJIT = 31.27s

# Ruby 3.2 = 39.80s
# Ruby 3.2 = 39.41s
# Ruby 3.2 = 39.64s

# Ruby 3.2 YJIT = 27.82s
# Ruby 3.2 YJIT = 27.79s
# Ruby 3.2 YJIT = 28.51s

# TruffleRuby 24.1 = 1.39s
# TruffleRuby 24.1 = 1.06s
# TruffleRuby 24.1 = 1.07s

# JRuby 9.4.9 = 47.02s
# JRuby 9.4.9 = 45.49s
# JRuby 9.4.9 = 48.22s
