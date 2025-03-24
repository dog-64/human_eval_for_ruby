def separate_paren_groups(paren_string)
  paren_string.gsub(/\s+/, '').scan(/\((?:[^()]*|\([^()]*\))*\)/).uniq
end