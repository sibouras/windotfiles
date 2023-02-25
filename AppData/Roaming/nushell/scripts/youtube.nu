def "youtube share" [url: string] {
  http get $url
  | str replace --all "<" "\n<"  # separate all HTML blocks into `<...> ...` chunks without the closing `</...>`
  | str replace --all "</.*>" ""
  | lines
  | find "var ytInitialPlayerResponse = "  # all the data is located in this JSON structure...
  | parse --regex 'var ytInitialPlayerResponse = (?<data>.*);'
  | get data.0
  | from json
  | get microformat.playerMicroformatRenderer  # ...and more specifically in this subfield
  | select embed.iframeUrl uploadDate ownerChannelName lengthSeconds title.simpleText  # select the most usefull fields
  | rename url date author length title
  | update length {|it| [$it.length "sec"] | str join | into duration}  # udpate some of the fields for clarity
  | update date {|it| $it.date | into datetime}
  | update url {|it| $it.url | str replace --string "www.youtube.com/embed" "youtu.be"}
}
