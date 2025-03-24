def file_name_check(file_name)
  valid_extensions = ['txt', 'exe', 'dll']
  return 'No' unless file_name.match?(/\A[a-zA-Z][a-zA-Z0-9_]*\.(?:#{valid_extensions.join("|")})\z/)
  return 'No' if file_name.split('.').last.length > 3
  'Yes'
end