# Check if CONTAINER_ID is empty or not set
# this will be the fish config for native machine
if test -z "$CONTAINER_ID"
    if status is-interactive
        # Commands to run in interactive sessions can go here
    end
    
    # add ~/.local/bin to PATH
    if not contains ~/.local/bin $PATH
      set -gx PATH ~/.local/bin $PATH
    end
    alias ls 'lsd -la'
    set fish_greeting
    # python env stuff
    alias gen_dev 'source $HOME/Env/.base/bin/activate.fish && which python'
    alias activate_py 'source .venv/bin/activate.fish'
    alias vim 'nvim'
    alias connect_hazel 'ssh -X ssthakar@login.hpc.ncsu.edu'
    alias connect_lab_ws 'ssh -Y ssthakar@mae-dt-009.mae.ncsu.edu'
    alias sftp_lab_ws 'sftp ssthakar@mae-dt-009.mae.ncsu.edu'
    alias sftp_hazel 'sftp ssthakar@login.hpc.ncsu.edu'
    alias zoom '/home/shri/AppImages/opt/zoom/ZoomLauncher'
    alias paraview 'flatpak run org.paraview.ParaView'
    alias rom 'cd $HOME/CoMAIL/CardioVascular/ROM_Models'
    alias svm 'cd $HOME/CoMAIL/CardioVascular/SV_Models'
    alias com 'cd $HOME/CoMAIL/'
    set -gx EDITOR nvim


    # for flex!
    #neofetch
end

# fish setup for ubuntu containers
if string match -q "ubuntu*" "$CONTAINER_ID"
  set fish_greeting "Running in an Ubuntu based container"
  alias simvascular '/usr/local/sv/simvascular/2023-03-27/bin/simvascular'

  alias gen_dev 'source $HOME/Env/.base/bin/activate.fish'
end

if string match -q "simvascular" "$CONTAINER_ID"
  set fish_greeting "Running in an Ubuntu based container"
  alias simvascular '/usr/local/sv/simvascular/2023-03-27/bin/simvascular'
  alias svpost /usr/local/sv/svsolver/2022-07-22/bin/svpost
  alias svpre /usr/local/sv/svsolver/2022-07-22/bin/svpre
  alias svsolver /usr/local/sv/svsolver/2022-07-22/bin/svsolver
end




# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/ssthakar/miniconda3/bin/conda
    eval /home/ssthakar/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/ssthakar/miniconda3/etc/fish/conf.d/conda.fish"
        . "/home/ssthakar/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/ssthakar/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

