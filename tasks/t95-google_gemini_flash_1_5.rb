def check_dict_case(hash)
  return false if hash.empty?
  
  all_strings = hash.keys.all? { |key| key.is_a?(String) }
  return false unless all_strings

  all_lowercase = hash.keys.all? { |key| key == key.downcase }
  all_uppercase = hash.keys.all? { |key| key == key.upcase }

  all_lowercase || all_uppercase
end
