def parse_music(music_string)
  durations = []
  music_string.split.each do |note|
    case note
    when 'o'
      durations << 4
    when 'o|'
      durations << 2
    when '.|'
      durations << 1
    end
  end
  durations
end
