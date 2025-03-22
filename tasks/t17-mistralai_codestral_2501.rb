def parse_music(music_string)
  note_map = {
    'o' => 4,
    'o|' => 2,
    '.|' => 1
  }
  music_string.split.map { |note| note_map[note] }.compact
end