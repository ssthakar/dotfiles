function fish_prompt
    if test -n "$SSH_TTY"
        echo -n (set_color brred)"$USER"(set_color white)'@'(set_color yellow)(prompt_hostname)' '
    end

    echo -n (set_color blue)(prompt_pwd)' '

    set_color -o
    
    if string match -q "simvascular" "$CONTAINER_ID"
        echo -n (set_color red)'❯'(set_color red)'❯'(set_color red)'❯ '
    end  
    
    #if fish_is_root_user
    #    echo -n (set_color red)'# '
    #end
    if test -z "$CONTAINER_ID"
        echo -n (set_color green)'❯'(set_color green)'❯'(set_color green)'❯ '
    end
    set_color normal
end
