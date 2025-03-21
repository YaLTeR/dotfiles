function fix-ssh
    set -x SSH_AUTH_SOCK (tmux showenv SSH_AUTH_SOCK | string split --max 1 --field 2 =)
end
