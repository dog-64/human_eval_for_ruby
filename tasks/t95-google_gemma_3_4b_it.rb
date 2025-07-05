def check_dict_case(hash)
  if hash.empty?
    return false
  end

  all_lower = hash.all? { |key, _| key.is_a?(String) && key.downcase == key }
  all_upper = hash.all? { |key, _| key.is_a?(String) && key.upcase == key }

  all_lower || all_upper
end
