def parse_music(music_string)
  result = []
  music_string.split.each do |token|
    case token
    when 'o'
      result << 4
    when 'o|'
      result << 2
    when '.|'
      result << 1
    end
  end
  result
end