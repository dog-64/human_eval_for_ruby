def check_dict_case(hash)
  return false unless hash.is_a?(Hash)

  keys = hash.keys
  all_lower = keys.all? { |key| key.is_a?(String) && key.downcase == key }
  all_upper = keys.all? { |key| key.is_a?(String) && key.upcase == key }

  all_lower || all_upper
end