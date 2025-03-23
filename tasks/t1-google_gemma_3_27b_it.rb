
def separate_paren_groups(paren_string)
  paren_string.gsub(/\s+/, '').scan(/\(([^()]*)\)/).map { |match| '(' + match[0] + ')' }
end
