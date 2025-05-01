def parse_music(music_string)
  note_durations = {
    'o' => 4,
    'o|' => 2,
    '.|' => 1
  }
  music_string.split.filter_map do |note|
    note_durations[note]
  end
end