u = ARGV[0].to_i                              # Get an input number from the command line
r = rand(10000)                               # Get a random number 0 <= r < 10k
a = Array.new(10000, 0)                       # Array of 10k elements initialized to 0

(0...10000).to_a.each do |i|                       # 10k outer loop iterations
  (0...100000).to_a.each do |j|                    # 100k inner loop iterations, per outer loop iteration
    a[i] += j % u                             # Simple sum
  end
  a[i] += r                                   # Add a random value to each element in array
end

puts a[r]                                     # Print out a single element from the array

# Running loop_array_each...

# Ruby 3.4 = 46.25s
# Ruby 3.4 = 46.29s
# Ruby 3.4 = 46.41s

# Ruby 3.4 YJIT = 25.83s
# Ruby 3.4 YJIT = 25.81s
# Ruby 3.4 YJIT = 25.76s

# Ruby 3.3 = 45.16s
# Ruby 3.3 = 45.45s
# Ruby 3.3 = 45.36s

# Ruby 3.3 YJIT = 42.98s
# Ruby 3.3 YJIT = 37.52s
# Ruby 3.3 YJIT = 37.29s

# Ruby 3.2 = 51.16s
# Ruby 3.2 = 50.73s
# Ruby 3.2 = 50.98s

# Ruby 3.2 YJIT = 38.61s
# Ruby 3.2 YJIT = 38.61s
# Ruby 3.2 YJIT = 38.81s

# TruffleRuby 24.1 = 1.94s
# TruffleRuby 24.1 = 1.66s
# TruffleRuby 24.1 = 1.66s

# JRuby 9.4.9 = 48.98s
# JRuby 9.4.9 = 48.44s
# JRuby 9.4.9 = 47.65s
