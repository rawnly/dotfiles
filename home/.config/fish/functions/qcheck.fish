function qcheck --wraps='xattr -p com.apple.quarantine' --description 'alias qcheck xattr -p com.apple.quarantine'
    xattr -p com.apple.quarantine $argv
end
