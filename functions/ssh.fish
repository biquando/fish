# The purpose of this function is to automatically start in tmux if we are
# connecting interactively to certain remotes.
#
# The command must match: `ssh <REMOTE>`
function ssh
    if not status is-interactive
        command ssh $argv
        return $status
    end

    # Do nothing if there isn't exactly one argument
    if [ (count $argv) -ne 1 ]
        command ssh $argv
        return $status
    end

    set -l remotes 'uapt' 'uaptt'
    # Do nothing if the remote doesn't match
    if not contains $argv[1] $remotes
        command ssh $argv
        return $status
    end

    command ssh -t $argv[1] -- 'tmux attach || tmux new-session'
end
