def parse_music(music_string)
  music_string.split.map { |note| case note when /o|./ then note =~ /^\.|$/ ? note[1..-1].to_i : note =~ /^o$/ ? 4 : 0 end }.compact
end