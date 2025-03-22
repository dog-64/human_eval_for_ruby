def check_dict_case(hash)
  return false if hash.empty? || !hash.keys.all? { |k| k.is_a?(String) }

  all_lower = hash.keys.all?(&:downcase) 
  all_upper = hash.keys.all?(&:upcase)

  all_lower || all_upper
end