function password -d "generate a random password"
    set -l length 16

    if test (count $argv) -gt 0
        set length $argv[1]
    end

    set -l pswd (openssl rand -base64 64 | LC_ALL=C tr -dc 'A-Za-z0-9!?%=' | head -c "$length")

    printf "%s" "$pswd"
end
