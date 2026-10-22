function pif --description 'pi with subagents + web-access loaded'
    set -l n ~/.pi/agent/npm/node_modules
    pi -e $n/pi-subagents -e $n/pi-web-access $argv
end
