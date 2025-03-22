def separate_paren_groups(paren_string)
  paren_string.scan(/\s*\(\s*(?:[^\(\)]|\(\s*[^\(\)]*\s*\))*\s*\)/).map(&:strip)
end