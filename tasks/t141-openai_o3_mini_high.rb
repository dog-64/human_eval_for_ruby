def file_name_check(file_name)
  parts = file_name.split('.')
  return "No" if parts.size != 2
  name, ext = parts
  return "No" if name.empty? || name[0] !~ /[A-Za-z]/
  return "No" unless ["txt", "exe", "dll"].include?(ext)
  return "No" if file_name.count("0-9") > 3
  "Yes"
end