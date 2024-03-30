# Derived from /opt/homebrew/Cellar/fish/3.6.0/share/fish/functions/prompt_login.fish
# Changes:
#  - make vcs prompt yellow instead of normal
#  - print number of background jobs
#  - private mode
function fish_prompt --description 'Write out the prompt (Custom)'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)
    set -q fish_color_status
        or set -g fish_color_status red

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l suffix '❯'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    # Write pipestatus
    # If the status was carried over (if no command is issued or if `set` leaves
    # the status untouched), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation
        or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

    # Show number of background jobs
    set -l njobs (jobs | wc -l | string trim)
    set -f prompt_jobs ""
    if test $njobs -gt 0
        set -f prompt_jobs " ($njobs)"
    end

    # Show private mode
    set -f prompt_private ''
    if set -q fish_private_mode
        set -f prompt_private '(private) '
    end

    echo -n -s \
        # (set_color white) '[' (date '+%T') '] ' \
        (prompt_login)' ' \
        (set_color brblack) $prompt_private $normal \
        (set_color $color_cwd) (prompt_pwd -D 2) \
        (set_color yellow) (fish_vcs_prompt) $normal \
        (set_color white) $prompt_jobs $normal \
        ' ' $prompt_status \
        '
 ' (set_color yellow) $suffix $normal ' '
end
