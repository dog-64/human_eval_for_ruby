
def parse_music(music_string)
    notes = music_string.split(" ")
    durations = []
    notes.each do |note|
        if note == "o"
            durations << 4
        elsif note == "o|"
            durations << 2
        elsif note == ".|"
            durations << 1
        end
    end
    return durations
end