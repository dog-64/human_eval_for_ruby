def file_name_check(file_name)
  # проверяем, соответствует ли имя файла заданным правилам валидации
  if file_name =~ /^[a-zA-Z]\.[txt|exe|dll]$/ && file_name.count(".") == 1 && file_name.split(".").last.size <= 3
    return "Yes"
  else
    return "No"
  end
end