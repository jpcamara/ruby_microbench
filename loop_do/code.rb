# frozen_string_literal: true

# Example from https://x.com/timtilberg/status/1861194052516864004
u = ARGV[0].to_i                              # Get an input number from the command line
r = rand(10_000)                               # Get a random number 0 <= r < 10k
a = Array.new(10_000, 0)                       # Array of 10k elements initialized to 0

i = 0
loop do
  break if i == 10_000

  j = 0
  loop do
    break if j == 100_000
    a[i] += j % u
    j += 1
  end

  a[i] += r
  i += 1
end

puts a[r]
