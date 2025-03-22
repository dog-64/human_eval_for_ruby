def check_dict_case(hash)
  return false unless hash.is_a?(Hash)
  return false if hash.empty?

  all_lower = true
  all_upper = true

  hash.each do |key, value|
    next unless key.is_a?(String)
    all_lower &&= key.downcase == key
    all_upper &&= key.upcase == key
  end

  return false if all_lower && all_upper
  return true if all_lower || all_upper
end