def file_name_check(file_name)
  return 'No' if file_name.count('.')!= 1
  name, extension = file_name.split('.')
  return 'No' if name.empty? ||!name[0].match?(/[a-zA-Z]/)
  return 'No' if extension!~ /\A(txt|exe|dll)\z/
  return 'No' if name.scan(/\d/).size > 3
  'Yes'
end