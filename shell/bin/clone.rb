#!/usr/bin/env ruby
# Paste an ugly URL from Github anywhere and launch a Tmux Window with a Vim session in it.

GITHUB_REPO_REGEX = %r{https://github.com/(?<org>[\w._-]+)/(?<project>[\w_\-.]+)(\.git)?}
SLASH_REGEX = %r{(?<org>[\w._-]+)/(?<project>[\w._-]+)}
FILE_REGEX = %r{/blob/(?<sha>\w+)/(?<path>[\w/.-_]+)(#L?)?(?<line>\d+)?}

local = ARGV.delete('-l')
no_vim = ARGV.delete('-n')
path_only = ARGV.delete('--path')
url = ARGV[0]
url ||= `chrome-cli info`.match(/^(?<title>Url: )(?<url>.+)/)['url']

match = url.match(GITHUB_REPO_REGEX)
match ||= url.match(SLASH_REGEX)
file_match = url.match(FILE_REGEX)

vim_command = 'nvim'

local_path = File.expand_path("~/src/github.com/#{match['org']}/#{match['project']}")
remote_url = "https://github.com/#{match['org']}/#{match['project']}.git"
if path_only
  puts local_path
  exit 0
end

system("git clone #{remote_url} #{local_path}") unless Dir.exist?(local_path)
exit 0 if no_vim

new_window_commands = [
  "cd #{local_path}",
  file_match && file_match['sha'] && "git checkout #{file_match['sha']}",
  no_vim ? '' : vim_command
]

new_window_commands = new_window_commands.compact.join(' && ')
print(new_window_commands)

if local
  system("tmux split-window -h -c \"#{local_path}\"")
  system(new_window_commands.to_s)
else
  new_window_index = `tmux new-window -c "#{local_path}" -P -F "#I" -n '#{match['project']}'`.strip
  puts("target_pane: #{new_window_index}")
  system("tmux send-keys -t #{new_window_index} \"#{new_window_commands}\" C-m")
  system("tmux split-window -t #{new_window_index} -h -c \"#{local_path}\"")
end

system('tmux select-pane -t:.1')