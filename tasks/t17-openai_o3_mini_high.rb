def parse_music(music_string)
  mapping = { "o" => 4, "o|" => 2, ".|" => 1 }
  music_string.split.map { |token| mapping[token] }.compact
end