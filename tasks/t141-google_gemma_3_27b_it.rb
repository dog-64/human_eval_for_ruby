
def file_name_check(file_name)
  return 'No' unless file_name.count('.') == 1

  parts = file_name.split('.')
  name = parts[0]
  extension = parts[1]

  return 'No' if name.empty? || !name[0].match?(/[a-zA-Z]/)
  return 'No' if extension.length < 2 || extension.length > 3
  return 'No' unless ['txt', 'exe', 'dll'].include?(extension)
  return 'No' if name.count(/\d/).to_i > 3

  'Yes'
end
