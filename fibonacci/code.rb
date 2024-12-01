def fibonacci(n)
    return 0 if n == 0
    return 1 if n == 1
    fibonacci(n - 1) + fibonacci(n - 2)
end

u = ARGV[0].to_i
r = 0

(1...u).each do |i|
    r += fibonacci(i)
end

puts r

# Running fibonacci...

# Ruby 3.4 = 16.81s
# Ruby 3.4 = 16.67s
# Ruby 3.4 = 16.70s

# Ruby 3.4 YJIT = 2.49s
# Ruby 3.4 YJIT = 2.45s
# Ruby 3.4 YJIT = 2.45s

# Ruby 3.3 = 16.63s
# Ruby 3.3 = 16.57s
# Ruby 3.3 = 16.59s

# Ruby 3.3 YJIT = 2.34s
# Ruby 3.3 YJIT = 2.34s
# Ruby 3.3 YJIT = 2.33s

# Ruby 3.2 = 15.29s
# Ruby 3.2 = 15.23s
# Ruby 3.2 = 15.24s

# Ruby 3.2 YJIT = 3.16s
# Ruby 3.2 YJIT = 3.16s
# Ruby 3.2 YJIT = 3.15s

# TruffleRuby 24.1 = 1.67s
# TruffleRuby 24.1 = 1.19s
# TruffleRuby 24.1 = 1.18s

# JRuby 9.4.9 = 7.92s
# JRuby 9.4.9 = 7.67s
# JRuby 9.4.9 = 8.31s
