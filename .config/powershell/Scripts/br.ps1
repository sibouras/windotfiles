# Change working dir to last dir in broot on exit.
$outcmd = new-temporaryfile
broot.exe --outcmd $outcmd $args
if (!$?) {
  remove-item -force $outcmd
  return $lastexitcode
}

$command = get-content $outcmd
if ($command) {
  # workaround - paths have some garbage at the start
  $command = $command.replace("\\?\", "", 1)
  invoke-expression $command
}
remove-item -force $outcmd
