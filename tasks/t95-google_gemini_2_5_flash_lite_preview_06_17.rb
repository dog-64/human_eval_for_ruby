def check_dict_case(hash)
  return false if hash.empty?
  keys = hash.keys
  return false unless keys.all? { |key| key.is_a?(String) }
  all_lower = keys.all? { |key| key == key.downcase }
  all_upper = keys.all? { |key| key == key.upcase }
  all_lower || all_upper
end
