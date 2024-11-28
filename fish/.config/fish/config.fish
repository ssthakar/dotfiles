# Check if CONTAINER_ID is empty or not set
if test -z "$CONTAINER_ID"
    if status is-interactive
        # Commands to run in interactive sessions can go here
    end
    alias ls 'lsd -A'
    set fish_greeting
    fastfetch
end

# fish setup for ubuntu-24.04 container
if test "$CONTAINER_ID" = "ubuntu_24"
  alias ls 'lsd -A'
  set fish_greeting "Running in container"
  fastfetch
end
