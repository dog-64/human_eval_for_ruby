def prime_length?(string)
  puts "#{__FILE__}:#{__LINE__} [DEBUG] | prime_length?(#{string})"
  length = string.length
  puts "#{__FILE__}:#{__LINE__} [DEBUG] | length=#{length.inspect}"
  return false if length < 2

  out = (2..Math.sqrt(length)).none? { |i| length % i == 0 }
  puts "#{__FILE__}:#{__LINE__} [DEBUG] | out=#{out.inspect}"
  out
end
