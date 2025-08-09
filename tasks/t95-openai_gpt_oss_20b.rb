def check_dict_case(hash)
  return false if hash.empty?
  keys = hash.keys
  return false unless keys.all? { |k| k.is_a?(String) }
  lower = keys.all? { |k| k == k.downcase }
  upper = keys.all? { |k| k == k.upcase }
  lower || upper
end