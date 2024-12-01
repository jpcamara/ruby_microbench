u = ARGV[0].to_i                              # Get an input number from the command line
r = rand(10000)                               # Get a random number 0 <= r < 10k
a = Array.new(10000, 0)                       # Array of 10k elements initialized to 0

10_000.times do |i|                           # 10k outer loop iterations
  100_000.times do |j|                        # 100k inner loop iterations, per outer loop iteration
    a[i] += j % u                             # Simple sum
  end
  a[i] += r                                   # Add a random value to each element in array
end

puts a[r]                                     # Print out a single element from the array

# Running loop_times...

# Ruby 3.4 = 33.61s
# Ruby 3.4 = 33.66s
# Ruby 3.4 = 33.56s

# Ruby 3.4 YJIT = 13.38s
# Ruby 3.4 YJIT = 13.37s
# Ruby 3.4 YJIT = 13.34s

# Ruby 3.3 = 33.15s
# Ruby 3.3 = 33.39s
# Ruby 3.3 = 33.42s

# Ruby 3.3 YJIT = 13.96s
# Ruby 3.3 YJIT = 14.00s
# Ruby 3.3 YJIT = 13.95s

# Ruby 3.2 = 39.45s
# Ruby 3.2 = 39.38s
# Ruby 3.2 = 39.94s

# Ruby 3.2 YJIT = 27.47s
# Ruby 3.2 YJIT = 27.31s
# Ruby 3.2 YJIT = 27.46s

# TruffleRuby 24.1 = 2.96s
# TruffleRuby 24.1 = 2.64s
# TruffleRuby 24.1 = 2.63s

# JRuby 9.4.9 = 46.86s
# JRuby 9.4.9 = 44.73s
# JRuby 9.4.9 = 46.63s
