#!/usr/bin/env fish

function notify_done
    set -q argv[1]
    and set title "$argv[1]"
    or set title Completed

    set -q argv[2]
    and set body "$argv[2]"
    or set body ""

    herdr notification show "$title" --body "$body" --sound done
end

function notify_request
    set -q argv[1]
    and set title "$argv[1]"
    or set title ""

    set -q argv[2]
    and set body "$argv[2]"
    or set body ""

    herdr notification show "$title" --body "$body" --sound request
end
