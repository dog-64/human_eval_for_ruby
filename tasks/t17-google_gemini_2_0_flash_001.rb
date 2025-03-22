def parse_music(music_string)
  durations = []
  notes = music_string.split
  notes.each do |note|
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