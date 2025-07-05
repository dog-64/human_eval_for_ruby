def check_dict_case(hash)
  return false if hash.empty?
  
  first_key_type = hash.keys.first
  return false unless first_key_type.is_a?(String)
  
  first_key_case = first_key_type.downcase
  
  all_lower_case = hash.all? { |key, _| key.is_a?(String) && key.downcase == first_key_case }
  
  all_upper_case = hash.all? { |key, _| key.is_a?(String) && key.upcase == first_key_type.upcase }
  
  all_lower_case || all_upper_case
end
