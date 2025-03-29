def file_name_check(file_name)
  return 'No' if file_name.empty? || !file_name.match(/\A[a-zA-Z]/) || !file_name.match(/\A[a-zA-Z]\d{0,3}\.(txt|exe|dll)\z/)
  'Yes'
end