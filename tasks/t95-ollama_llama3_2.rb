def check_dict_case(hash)
  return false if hash.empty?
  all_lower = true
  all_upper = true
  hash.each do |key, value|
    return false unless key.is_a?(String)
    return false if key =~ /\A\W+\z/
    all_lower = false if key.downcase != key
    all_upper = false if key.upcase != key
  end
  all_lower && all_upper
end