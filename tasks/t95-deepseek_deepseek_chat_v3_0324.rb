def check_dict_case(hash)
  return false if hash.empty?

  keys = hash.keys
  return false unless keys.all? { |k| k.is_a?(String) }

  lower_case = keys.all? { |k| k == k.downcase }
  upper_case = keys.all? { |k| k == k.upcase }

  lower_case || upper_case
end