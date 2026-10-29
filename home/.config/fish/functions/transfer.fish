function transfer
    set -l remote homeserver
    set -l remote_dir /tmp/transf

    if test (count $argv) -ne 1
        echo "Usage: transfer <file>"
        return 1
    end

    set -l input $argv[1]

    # Local file exists → upload
    if test -f "$input"
        set -l filename (basename "$input")

        # Make sure remote directory exists
        ssh $remote "mkdir -p '$remote_dir'" \
            or return 1

        scp "$input" "$remote:$remote_dir/$filename" \
            or return 1

        echo "↑ $filename"
        return 0
    end

    # Local file doesn't exist → try downloading it
    set -l filename (basename "$input")
    set -l remote_path "$remote_dir/$filename"

    ssh $remote "test -f '$remote_path'"
    if test $status -ne 0
        echo "transfer: '$filename' not found locally or remotely"
        return 1
    end

    # Download
    scp "$remote:$remote_path" "./$filename" \
        or return 1

    echo "↓ $filename"

    # Delete only after successful download
    ssh $remote "rm -- '$remote_path'" \
        or begin
    echo "⚠ downloaded, but failed to delete remote file"
    return 1

end
