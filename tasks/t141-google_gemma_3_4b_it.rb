def file_name_check(file_name)
  if file_name.include?('.')
    parts = file_name.split('.')
    if parts.length != 2
      return 'No'
    end

    first_part = parts[0]
    last_part = parts[1]

    if first_part.empty?
      return 'No'
    end

    if !first_part[/^[a-zA-Z]/].empty?
      return 'No'
    end

    if last_part.nil?
      return 'No'
    end

    if last_part.empty?
      return 'No'
    end

    valid_extensions = ['txt', 'exe', 'dll']
    if !valid_extensions.include?(last_part)
      return 'No'
    end

    digit_count = first_part.count { |char| char =~ /\d/ }
    if digit_count > 3
      return 'No'
    end

    return 'Yes'
  else
    return 'No'
  end
end
