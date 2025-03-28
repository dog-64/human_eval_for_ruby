def file_name_check(file_name)
  return 'No' unless file_name.count('.') == 1

  parts = file_name.split('.')
  return 'No' if parts.size != 2 || parts.any?(&:empty?)

  name_part, extension = parts
  valid_extensions = %w[txt exe dll]

  return 'No' unless valid_extensions.include?(extension)
  return 'No' unless name_part.match?(/^[a-zA-Z]/)
  return 'No' if name_part.count('0-9') > 3

  'Yes'
end