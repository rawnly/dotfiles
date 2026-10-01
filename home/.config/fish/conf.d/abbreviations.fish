abbr -a gcd 'git switch $(git symbolic-ref refs/remotes/origin/HEAD --short | sd "origin/" "")'
abbr -a gcm 'git switch $(git symbolic-ref refs/remotes/origin/HEAD --short | sd "origin/" "")'
abbr -a gc "git switch"
abbr -a gs "git status -s"
abbr -a gl "git pull"
abbr -a gm "git merge"
abbr -a grb "git rebase"
abbr -a curl curlie
abbr -a md "mkdir -p"
abbr -a j just
abbr -a r ranger
abbr -a nv nvim
abbr -a g git
abbr -a p pnpm
abbr -a b brew
abbr -a m make
abbr -a t tmux
abbr -a la lazygit
abbr -a sl ls
abbr -a gd --set-cursor "git diff %"
abbr -a acommit 'ai-commit commit'
abbr -a first 'head -n 1'
abbr -a last 'tail -n 1'
abbr -a genpass genpass-monkey
abbr -a gck "git checkout -"
abbr -a gs "git status -s"

abbr -a gr 'cd $(git rev-parse --show-toplevel)'

alias br 'bracco --edit --preview "bat -p --theme luna {}" --vim'

function tickets
    set -q argv[1]
    and set issue_state "$argv[1]"
    or set issue_state all

    gh ticket ls -A @me -s "$issue_state" --json number,title,url \
        | jq -r '["ID","TITLE","URL"], (.[] | [.number,.title,.url]) | @tsv' \
        | column -t -s (printf '\t')
end

function kctx --description "Switch kubectl context"
    set -q argv[1]
    and set environment "$(string trim -r $argv[1])"

    if test -n "$environment"
        kubectl config use-context "services-eks-cluster-$environment"
    else
        kubectl config current-context
    end
end
