def parse_music(music_string)
  result = []
  music_string.split(' ').each do |note|
    case note
    when 'o' then result << 4
    when 'o|' then result << 2
    when '.|' then result << 1
    end
  end
  result
end