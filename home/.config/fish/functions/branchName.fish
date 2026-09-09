function branchName
    # Native git way (fastest)
    git branch --show-current 2>/dev/null
    
    # If you prefer the logic you had (stripping stars/colors manually):
    # command git branch | string match -r '\*.*' | string replace '* ' ''
end
