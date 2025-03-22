def file_name_check(file_name)
  return 'No' if !file_name.match?(/^[a-zA-Z][^\.]*\.(txt|exe|dll)$/)

  return 'Yes' if file_name.match?(/^[a-zA-Z][^\.]*\.(txt|exe|dll)$/)

  return 'No'
end