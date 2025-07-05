
 not valid. We should probably reset `balance` and `current_group_start_index` and continue scanning. Or, more simply, if `balance` becomes 0, it *must* havedef separate_paren_groups(paren_string)
  no_space_string = paren_string.gsub(/\s+/, '')
  result_groups = []