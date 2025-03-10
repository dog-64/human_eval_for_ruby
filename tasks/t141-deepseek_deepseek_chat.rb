def file_name_check(file_name)
    return 'No' unless file_name.count('.') == 1
    parts = file_name.split('.')
    return 'No' if parts[0].empty? || !parts[0][0].match?(/[a-zA-Z]/)
    return 'No' unless ['txt', 'exe', 'dll'].include?(parts[1])
    return 'No' if parts[0].gsub(/\D/, '').length > 3
    'Yes'
end