def file_name_check(file_name)
  parts = file_name.split('.')
  return 'No' unless parts.size == 2

  name, ext = parts

  return 'No' if name.empty? || name[0] !~ /[a-zA-Z]/
  return 'No' unless %w[txt exe dll].include?(ext)
  return 'No' if file_name.scan(/\d/).count > 3

  'Yes'
end