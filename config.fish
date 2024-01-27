function fish_prompt
  set prev_status $status
  set_color -o green
  printf '%s' $USER
  printf '@'
  printf '%s' $hostname
  set_color -o white
  printf ':'
  set_color -o brblue
  printf '%s' (prompt_pwd)
  printf ' %s' (home-cleaning short)
  if test $prev_status -eq 0;
    set_color -o normal
  else
    set_color -o red
  end

  printf '❯ '
  set_color -o normal
end

function fish_title
  pwd
end

function fish_greeting
end

if status is-interactive
  fish_add_path ~/bin
  fish_add_path /home/sam/install/node-v20.11.0-linux-x64/bin
  fish_add_path ~/superego
  fish_add_path /usr/local/bin
  fish_add_path /usr/sbin/
  fish_add_path /usr/local/go/bin

  export EDITOR=nvim
  export PATH="$HOME/.cargo/bin:$PATH"

  # Man colors
  set -x LESS_TERMCAP_mb (printf "\e[1;32m")
  set -x LESS_TERMCAP_md (printf "\e[1;32m")
  set -x LESS_TERMCAP_me (printf "\e[0m")
  set -x LESS_TERMCAP_se (printf "\e[0m")
  set -x LESS_TERMCAP_so (printf "\e[01;33m")
  set -x LESS_TERMCAP_ue (printf "\e[0m")
  set -x LESS_TERMCAP_us (printf "\e[1;4;31m")

  set fish_prompt_pwd_dir_length 0 # Disable CWD shortening

  # Bindings
  bind \ce edit_command_buffer
  bind \cs "echo;git status .; commandline -f repaint"

  # Aliases
  alias clippy 'cargo clippy -- -W clippy::pedantic -W clippy::nursery -W clippy::unwrap_used'
  alias clippy-fix 'cargo clippy --fix -- -W clippy::pedantic -W clippy::nursery -W clippy::unwrap_used'
  alias ls '/bin/ls --color=auto'
  alias r ranger
  alias v nvim
end
