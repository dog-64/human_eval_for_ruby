def separate_paren_groups(paren_string)
  paren_string.gsub(/\s+/, '').split(/(?<=\()(?=[^\(]*\))/).select { |group| group.count('(') == group.count(')') }
end