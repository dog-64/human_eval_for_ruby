
def file_name_check(file_name)
  parts = file_name.split('.')
  return 'No' unless parts.size == 2

  name_part, ext_part = parts

  return 'No' if name_part.empty? || !name_part.match?(/^[a-zA-Z]/)
  return 'No' unless ['txt', 'exe', 'dll'].include?(ext_part)
  return 'No' if file_name.count('0'..'9') > 3

  'Yes'
end

 