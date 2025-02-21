# Check if CONTAINER_ID is empty or not set
if test -z "$CONTAINER_ID"
    if status is-interactive
        # Commands to run in interactive sessions can go here
    end
    alias ls 'lsd -A'
    set fish_greeting
    # python env stuff
    alias gen_dev 'source $HOME/Mlab/Python_stuff/Env/gen_dev/bin/activate.fish && which python'
    alias jax 'source $HOME/Mlab/Python_stuff/Env/JAX/bin/activate.fish && which python'
    alias activate_py 'source .venv/bin/activate.fish'
    alias vim 'nvim'
    
    # conda env
    set -x CRYPTOGRAPHY_OPENSSL_NO_LEGACY 1   


    # for flex!
    fastfetch
end

# fish setup for ubuntu containers
if string match -q "ubuntu*" "$CONTAINER_ID"
  set fish_greeting "Running in an Ubuntu based container"
  alias simvascular '/usr/local/sv/simvascular/2023-03-27/bin/simvascular'
end

if string match -q "simvascular" "$CONTAINER_ID"
  set fish_greeting "Running in an Ubuntu based container"
  alias simvascular '/usr/local/sv/simvascular/2023-03-27/bin/simvascular'
end


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/anaconda/bin/conda
    eval /opt/anaconda/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/opt/anaconda/etc/fish/conf.d/conda.fish"
        . "/opt/anaconda/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/opt/anaconda/bin" $PATH
    end
end
# <<< conda initialize <<<

