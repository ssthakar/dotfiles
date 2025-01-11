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
    
    # for flex!
    fastfetch
end

# fish setup for ubuntu containers
if string match -q "ubuntu*" "$CONTAINER_ID"
  set fish_greeting "Running in an Ubuntu based container"
  alias simvascular '/usr/local/sv/simvascular/2023-03-27/bin/simvascular'
end
