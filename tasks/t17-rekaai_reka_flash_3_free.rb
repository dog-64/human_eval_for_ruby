
def parse_music(music_string)
  note_durations = { 'o' => 4, 'o|' => 2, '.|' => 1 }
  music_string.split(/\s+/).map { |note| note_durations.fetch(note, nil) }.compact
end

 