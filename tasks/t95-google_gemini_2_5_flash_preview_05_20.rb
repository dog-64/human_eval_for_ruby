def check_dict_case(hash)
  return false if hash.empty?

  keys = hash.keys
  return false unless keys.all? { |k| k.is_a?(String) }

  first_key = keys.first
  is_lower = first_key == first_key.downcase
  is_upper = first_key == first_key.upcase

  return false unless is_lower || is_upper

  if is_lower
    keys.all? { |k| k == k.downcase }
  else # is_upper
    keys.all? { |k| k == k.upcase }
  end
end