def check_dict_case(hash)
  return false unless hash.is_a?(Hash)
  all_lower = true
  all_upper = true
  hash.each do |key, value|
    next if key.is_a?(String) && (key.downcase == key || key.upcase == key)
    all_lower = false
    all_upper = false
    break
  end
  return false unless all_lower || all_upper
  true
end