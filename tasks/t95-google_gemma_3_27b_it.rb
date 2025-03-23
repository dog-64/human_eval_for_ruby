
def check_dict_case(hash)
  return false if hash.empty?

  all_lower = true
  all_upper = true

  hash.each_key do |key|
    return false unless key.is_a?(String)

    all_lower = false if key != key.downcase
    all_upper = false if key != key.upcase
  end

  all_lower || all_upper
end
