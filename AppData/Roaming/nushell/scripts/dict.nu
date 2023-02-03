# Function querying free online English dictionary API for definition of given word(s)
def dict [...word #word(s) to query the dictionary API but they have to make sense together like "martial law", not "cats dogs"
] {
  let query = ($word | str collect %20)
  let link = ('https://api.dictionaryapi.dev/api/v2/entries/en/' + $query)
  let output = (http get $link | rename word)
  let w = ($output.word | first)
  if $w == "No Definitions Found" {
    echo $output.word
  } else {
    echo $output.meanings | flatten | get definitions  | flatten
    # echo $output.meanings.definitions | flatten | flatten
    # | select definition example
  }
}
