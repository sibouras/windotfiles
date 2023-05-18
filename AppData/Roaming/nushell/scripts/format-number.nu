# format a number
def format-number [ num ,
  --thousands_delim (-t) = ' '  # Thousands delimiter: format-number 1000 -t "'": 1'000
  --decimal_digits (-d) = 0     # Number of digits after decimal delimiter: format-number 1000.1234 -d 2: 1000.12
  --denom = ""                  # Denom `--denom "Wt": format-number 1000 --denom 'Wt': 1000Wt
  ] {
  let int_part = ($num // 1)

  let int_part_f = ( $int_part | into string | split chars | reverse | enumerate | each {
    |it| if ((($it.index + 1) mod 3) == 0) {
      $"($thousands_delim)($it.item)"
    } else {
      $it.item
    }
  } | reverse | str join '')

  let int_part_f2 = (if ($int_part_f | str substring 0..1) == $thousands_delim {
    ($int_part_f | str substring 1..)
  } else {
    $int_part_f
  } )

  let digits_after_dot = ($decimal_digits + 2)

  let dec_part = if $decimal_digits == 0 {""} else {
    ($num mod 1) | math round -p $decimal_digits | into string | str substring 1..($digits_after_dot)
  }

  $"(ansi green)($int_part_f2)($dec_part)(ansi reset)(ansi green_bold)($"($denom)")(ansi reset)"
}
