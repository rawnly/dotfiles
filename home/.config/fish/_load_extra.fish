#!/usr/bin/env fish

if test -n "$_fish_profile"
    set -l confdir $__fish_config_dir/conf.d
    set -l subdirs $_fish_profile

    for dir in $subdirs
        for file in $confdir/$dir/*.fish
            source $file
        end
    end
end
