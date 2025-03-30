
def check_dict_case(hash)
  return false if hash.empty?

  keys = hash.keys

  unless keys.all? { |k| k.is_a?(String) }
    return false
  end

  all_lower = keys.all? { |k| k.downcase == k }
  all_upper = keys.all? { |k| k.upcase == k }

  all_lower || all_upper
end

 