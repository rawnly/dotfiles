function unquarantine --wraps='xattr -d com.apple.quarantine' --description 'alias unquarantine xattr -d com.apple.quarantine'
    xattr -d com.apple.quarantine $argv
end
