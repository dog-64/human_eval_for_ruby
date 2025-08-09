def check_dict_case(hash)
  return false if hash.empty?
  hash.each_key do |k|
    return false unless k.is_a?(String)
  end
  first = hash.keys.first
  if first == first.downcase
    expected = :down
  elsif first == first.upcase
    expected = :up
  else
    return false
  end
  hash.each_key do |k|
    case expected
    when :down
      return false unless k == k.downcase
    when :up
      return false unless k == k.upcase
    end
  end
  true
end