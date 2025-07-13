def check_dict_case(hash)
  return false if hash.empty?
  
  keys = hash.keys
  return false unless keys.all? { |key| key.is_a?(String) }
  
  lower_case_keys = keys.all? { |key| key == key.downcase }
  upper_case_keys = keys.all? { |key| key == key.upcase }
  
  lower_case_keys || upper_case_keys
end