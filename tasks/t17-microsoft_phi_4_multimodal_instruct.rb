def parse_music(music_string)
  music_string.split.map { |note| note.match(/o+| .+|\./).to_i }
end