def file_name_check(file_name)
    if file_name =~ /^[a-zA-Z][a-zA-Z0-9]*\.([txt|exe|dll])$/
        return 'Yes'
    else
        return 'No'
    end
end