# frozen_string_literal: true

u = ARGV[0].to_i                              # Get an input number from the command line
r = rand(10_000)                               # Get a random number 0 <= r < 10k
a = Array.new(10_000, 0)                       # Array of 10k elements initialized to 0

i = 0
while i < 10_000                                # 10k outer loop iterations
  j = 0
  while j < 100_000                              # 100k inner loop iterations, per outer loop iteration
    a[i] += j % u                             # Simple sum
    j += 1
  end
  a[i] += r                                   # Add a random value to each element in array
  i += 1
end

puts a[r]                                     # Print out a single element from the array