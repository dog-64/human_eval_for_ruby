def file_name_check(file_name)
  return 'No' unless file_name.count('.') == 1
  name, ext = file_name.split('.')
  return 'No' if name.empty? || !name.match?(/\A[A-Za-z]/)
  return 'No' unless ['txt', 'exe', 'dll'].include?(ext)
  return 'No' if name.gsub(/\D/, '').length > 3
  'Yes'
end