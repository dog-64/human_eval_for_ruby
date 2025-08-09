def file_name_check(file_name)
  return 'No' unless file_name.count('.') == 1
  name, ext = file_name.split('.', 2)
  return 'No' if name.nil? || name.empty?
  return 'No' if ext.nil? || ext.empty?
  return 'No' unless %w[txt exe dll].include?(ext.downcase)
  return 'No' unless name[0] =~ /[A-Za-z]/
  return 'No' if file_name.scan(/\d/).size > 3
  'Yes'
end