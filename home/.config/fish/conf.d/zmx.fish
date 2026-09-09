complete -c zmx -f

set -l subcommands attach run detach list completions kill history version help
set -l no_subcmd "not __fish_seen_subcommand_from $subcommands"

complete -c zmx -n $no_subcmd -a attach -d 'Attach to session, creating if needed'
complete -c zmx -n $no_subcmd -a run -d 'Send command without attaching'
complete -c zmx -n $no_subcmd -a detach -d 'Detach all clients from current session'
complete -c zmx -n $no_subcmd -a list -d 'List active sessions'
complete -c zmx -n $no_subcmd -a completions -d 'Shell completion scripts'
complete -c zmx -n $no_subcmd -a kill -d 'Kill a session'
complete -c zmx -n $no_subcmd -a history -d 'Output session scrollback'
complete -c zmx -n $no_subcmd -a version -d 'Show version'
complete -c zmx -n $no_subcmd -a help -d 'Show help message'

complete -c zmx -n "__fish_seen_subcommand_from attach run kill history" -a '(zmx list --short 2>/dev/null)' -d 'Session name'

complete -c zmx -n "__fish_seen_subcommand_from completions" -a 'bash zsh fish' -d Shell

complete -c zmx -n "__fish_seen_subcommand_from list" -l short -d 'Short output'
