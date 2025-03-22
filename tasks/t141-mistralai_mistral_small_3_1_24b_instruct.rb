def file_name_check(file_name)
  return 'No' unless file_name.match?(/^[a-zA-Z][a-zA-Z0-9]*\.[a-zA-Z]{3}$/)
  return 'No' if file_name.scan(/\d/).size > 3
  return 'No' unless ['txt', 'exe', 'dll'].include?(file_name.split('.').last)
  'Yes'
end