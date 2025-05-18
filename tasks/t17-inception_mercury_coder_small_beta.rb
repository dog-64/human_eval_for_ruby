def parse_music(music_string)
  music_string.split(' ').map do |note|
    case note
    when 'o'
      4
    when 'o|'
      2
    when '.|'
      1
    else
      nil
    end
  end.compact
end