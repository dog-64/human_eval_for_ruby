def check_dict_case(hash)
  return false if hash.empty?

  keys = hash.keys
  return false unless keys.all? { |key| key.is_a?(String) }

  all_downcase = keys.all?(&:downcase?)
  all_upcase = keys.all?(&:upcase?)

  all_downcase || all_upcase
end
