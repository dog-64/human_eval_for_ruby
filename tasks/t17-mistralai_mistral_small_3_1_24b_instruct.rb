def parse_music(music_string)
  music_string.split.map do |note|
    case note
    when 'o' then 4
    when 'o|' then 2
    when '.|' then 1
    end
  end.compact
end