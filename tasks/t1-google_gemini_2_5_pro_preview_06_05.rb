
 ) (( )) (( )( ))'`

1.  `cleaned_string = paren_string.gsub(/\s+/, '')` -> `'()(())()
'`
2.  `groups = []`, `current_group = ""`, `balance = 0`
3.  Loop through `'()(())()()