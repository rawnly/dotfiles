function pkg -a key -d "extract keys from package.json"
    if ! test -f package.json
        echo "no manifest."
        return
    end

    if test (count $argv) -eq 0
        echo "Usage: pkg <key>"
        return
    end

    jq -r ".$key" <package.json
end

function scripts
    jq .scripts <package.json
end
