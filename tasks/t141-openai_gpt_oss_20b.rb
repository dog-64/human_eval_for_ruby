def file_name_check(file_name)
  return 'No' unless file_name.is_a?(String)

  parts = file_name.split('.')
  return 'No' unless parts.size == 2

  name_part, ext_part = parts
  return 'No' if name_part.empty?
  return 'No' unless name_part[0] =~ /[A-Za-z]/
  return 'No' unless %w[txt exe dll].include?(ext_part)

  digit_count = file_name.count('0-9')
  return 'No' if digit_count > 3

  'Yes'
end