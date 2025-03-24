def check_dict_case(hash)
  return false если hash пуст или hash.any? { |k, _| !k.is_a?(String) }
  keys = hash.keys
  keys.uniq.all? { |k| k.match?(/\A[A-Z]+\z/) || k.match?(/\A[a-z]+\z/) }
end