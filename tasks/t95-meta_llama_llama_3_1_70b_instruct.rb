def check_dict_case(hash)
  return false if hash.empty?
  all_lower = hash.keys.all? { |key| key.is_a?(String) && key == key.downcase }
  all_upper = hash.keys.all? { |key| key.is_a?(String) && key == key.upcase }
  all_lower || all_upper
end