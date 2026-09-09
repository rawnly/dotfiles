function portPid -d "Get the PID running on a specific port"
    if test (count $argv) -eq 0
        echo "usage: portPid <ports>"
        return 1
    end

    # Use lsof to find the PID
    for port in $argv
        set -l pid (lsof -t -i tcp:$port)
        if test -n "$pid"
            echo $pid
        else
            if test (count $argv) -eq 1
                echo "No process found on port $argv[1]"
                return 1
            end
        end
    end
end
