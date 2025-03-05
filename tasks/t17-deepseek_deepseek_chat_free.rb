```ruby
def parse_music(music_string)
  notes = music_string.split
  notes.map do |note|
    case note
    when 'o' then 4
    when 'o|' then 2
    when '.|' then 1
    else 0
    end
  end.reject(&:zero?)
end
```


def parse_music(music_string)
  notes = music_string.split
  notes.map do |note|
    case note
    when 'o' then 4
    when 'o|' then 2
    when '.|' then 1
    else 0
    end
  end.reject(&:zero?)
end