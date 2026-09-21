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
 
    # better ls using lsd
    alias ls 'lsd -la'
    set fish_greeting
    
    # ranger stuff
    alias rng 'ranger .'
    alias th 'thunar .'
    # python env stuff
    alias gen_dev 'source $HOME/Env/.base/bin/activate.fish && which python'
    alias jax_13 'source $HOME/Env/.jax_cuda_13/bin/activate.fish && which python'
    alias activate_py 'source .venv/bin/activate.fish'
    alias ipy 'gen_dev && ipython'

    # vim as nvim
    alias vim 'nvim'    
    alias paraview 'flatpak run org.paraview.ParaView'

    # ssh aliases
    alias connect_hazel 'ssh -X ssthakar@login.hpc.ncsu.edu'
    alias connect_lab_ws 'ssh -Y ssthakar@mae-dt-009.mae.ncsu.edu'
    alias sftp_lab_ws 'sftp ssthakar@mae-dt-009.mae.ncsu.edu'
    alias sftp_hazel 'sftp ssthakar@login.hpc.ncsu.edu'
 
    # flatpak and app images aliases
    alias zoom '/home/shri/AppImages/opt/zoom/ZoomLauncher'
    # alias paraview 'flatpak run org.paraview.ParaView'

    # CardioVascular aliases for most used directories
    alias rom 'cd $HOME/CoMAIL/CardioVascular/ROM_Models'
    alias svm 'cd $HOME/CoMAIL/CardioVascular/SV_Models'
    alias com 'cd $HOME/CoMAIL/'

    set -gx EDITOR nvim

    # simvascular aliases, exported from distrobox installation, will be fucked if distrobox breaks
    alias svpost '~/.local/bin/svpost'
    alias svpre '~/.local/bin/svpre'
    alias svsolver '~/.local/bin/svsolver'
    alias dysk '/home/ssthakar/dysk/build/x86_64-linux/dysk'

    # Temp for now, don't have any idea wtf I am doing
    #
    #

    set -Ux LD_LIBRARY_PATH /home/ssthakar/CoMAIL/CardioVascular/SV_Models/AO3/3D_sims/Arc_transfers/ao3_8/export/svSlicer/vtk/lib $LD_LIBRARY_PATH
    alias cd2 'cd ../../'
    alias cd3 'cd ../../../'
    alias cd4 'cd ../../../../'

    if test "$TERM_PROGRAM" = "ghostty"
       export TERM=xterm-256color
    end

    alias gedit 'nvim'
    
    # Mount and unmount research storage
    # alias mount_research='sudo mount -t nfs rs.oit.ncsu.edu:/rs1/researchers/m/mmirram ~/research_share'
    # alias umount_research='sudo umount ~/research_share'


    function mount_research
        cd $HOME
        sudo mount -t nfs rs.oit.ncsu.edu:/rs1/researchers/m/mmirram ~/research_share
        if test $status -eq 0
            echo "✅ Mounted research storage at ~/research_share"
        else
            echo "❌ Failed to mount research storage"
        end
    end

    function umount_research
        cd $HOME
        sudo umount ~/research_share
        if test $status -eq 0
            echo "✅ Unmounted research storage"
        else
            echo "❌ Failed to unmount research storage"
        end
    end


    # --- safe rm wrapper for fish ---
    # blocks rm -rf, rm -fr, --no-preserve-root, and deletes aimed at / or $HOME
    # use `reallyrm` to intentionally bypass

    function __rm_is_flag --argument-names f
        string match -q -r '^-.*' -- $f
    end

    function __rm_has_recursive --argument-names f
        # -r, -R, or any short bundle containing r/R; also --recursive
        if test $f = '-r' -o $f = '-R' -o $f = '--recursive'
            return 0
        end
        string match -q -r '^-[^-]*[rR]' -- $f
    end

    function __rm_has_force --argument-names f
        # -f or bundled; also --force
        if test $f = '-f' -o $f = '--force'
            return 0
        end
        string match -q -r '^-[^-]*f' -- $f
    end

    function __rm_is_no_preserve_root --argument-names f
        test $f = '--no-preserve-root'
    end

    function __rm_target_is_bad --argument-names p
        # Resolve and check for / or $HOME
        # Ignore flags or empty
        if not __rm_is_flag $p
            # normalize path; -m tolerates non-existent
            set -l rp (realpath -m -- $p ^/dev/null)
            # treat empty expansion (like globs not matching) as safe noop
            if test -n "$rp"
                if test "$rp" = "/" -o "$rp" = "$HOME"
                    return 0
                end
            end
        end
        return 1
    end

    function reallyrm --description "Bypass guard and run rm directly"
        command rm $argv
    end

    function rm --description "Safe rm with guardrails"
        # Allow a one-off bypass via env var if you *really* must:
        #   FISH_RM_ALLOW=1 rm -rf some/dir
        if set -q FISH_RM_ALLOW; and test "$FISH_RM_ALLOW" = "1"
            command rm $argv
            return $status
        end

        set -l has_r 1  # default false, fish uses 0 success / nonzero fail; so invert
        set -l has_f 1
        set -l nope 1

        # scan flags
        for a in $argv
            if __rm_is_no_preserve_root $a
                echo "🛑 gtfo: refusing to run rm with --no-preserve-root." >&2
                return 64
            end
            if __rm_has_recursive $a
                set has_r 0
            end
            if __rm_has_force $a
                set has_f 0
            end
        end

        # block any combo that has both -r and -f (in any order/bundle)
        if test $has_r -eq 0 -a $has_f -eq 0
            echo "🛑 hard block dumbass!!!  'rm -rf' (or equivalent) is disabled. Use 'reallyrm' if you're 100% sure." >&2
            return 64
        end

        # block obviously catastrophic targets
        for a in $argv
            if __rm_target_is_bad $a
                echo "🛑 what the actual f**k!! absolutely not: you're aiming at '/' or your \$HOME. Blocked." >&2
                return 64
            end
        end

        # Safer default: -I prompts once if removing >3 files or recursively (GNU rm).
        # If your rm doesn't support -I, switch to -i.
        command rm -I $argv
    end


    # fish setup for native machine
    alias edit_fish_config 'nvim ~/dotfiles/fish/.config/fish/config.fish'

    # pipe output to xclip for quick copy and paste
    
    function clip --description 'Run a command and copy its output to the X clipboard'
        if test (count $argv) -eq 0
            echo 'Usage: clip <command> [args …]' >&2
            return 1
        end

        # Execute the given command (+ args) and pipe its stdout to xclip
        command $argv | xclip -selection clipboard -silent
    end

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



# Who the fuck uses conda man

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

eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
