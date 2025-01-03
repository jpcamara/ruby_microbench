# frozen_string_literal: true

u = ARGV[0].to_i                              # Get an input number from the command line
r = rand(10_000)                              # Get a random number 0 <= r < 10k
a = Array.new(10_000, 0)                      # Array of 10k elements initialized to 0

outer = (0...10_000).to_a.freeze
inner = (0...100_000).to_a.freeze
outer.each do |i|                             # 10k outer loop iterations
  inner.each do |j|                           # 100k inner loop iterations, per outer loop iteration
    a[i] += j % u                             # Simple sum
  end
  a[i] += r                                   # Add a random value to each element in array
end

puts a[r]                                     # Print out a single element from the array
