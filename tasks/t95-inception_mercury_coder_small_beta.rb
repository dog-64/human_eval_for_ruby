def check_dict_case(hash)
  keys = hash.keys
  return false if keys.empty?
  return false unless keys.all? { |k| k.is_a?(String) }
  all_lower = keys.all? { |k| k == k.downcase }
  all_upper = keys.all? { |k| k == k.upcase }
  all_lower || all_upper
end