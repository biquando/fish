function __fish_user_set_path
    switch $_UNAMESYS
        case 'Darwin'; set pathlist \
            $HOME/.cargo/bin \
            /opt/homebrew/bin \
            /opt/homebrew/sbin \
            /Applications/Docker.app/Contents/Resources/bin
        case 'Linux'; set pathlist \
            $HOME/services/bin
    end

    fish_add_path -g $HOME/bin $HOME/.local/bin
    fish_add_path -g $pathlist
end
