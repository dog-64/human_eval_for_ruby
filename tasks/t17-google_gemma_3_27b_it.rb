
def parse_music(music_string)
  notes = music_string.split
  result = []
  notes.each do |note|
    case note
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
