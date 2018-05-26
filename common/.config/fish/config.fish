alias l "ls -hl"

alias g    "git"
alias ga   "git add"
alias gau  "git add -u"
alias gc   "git commit"
alias gca  "git commit -a"
alias gcam "git commit -am"
alias gch  "git checkout"
alias gcm  "git commit -m"
alias gd   "git diff"
alias gf   "git fetch"
alias gl   "git log"
alias gm   "git merge"
alias gpul "git pull"
alias gpus "git push"
alias gr   "git rebase"
alias gri  "git rebase -i"
alias grm  "git remote"
alias gs   "git status"
alias gsh  "git show"

# Fix emoji and others rendering
set -g fish_emoji_width 2

# Initialize the gnome-keyring-daemon
# set -l gnome_keyring_vars (gnome-keyring-daemon --start)
# eval (echo $gnome_keyring_vars | sed -e 's/^\(.*\)$/set -x \\1;/' -e 's/=/ /')

# Vi key bindings
fish_vi_key_bindings

# # Base16 Shell
# if status --is-interactive
# 	eval sh $HOME/.config/base16-shell/scripts/base16-ashes.sh
# end

function fish_prompt
	set -l last_status $status

	echo -n '┌ '

	# Vi mode indicator
	# Do nothing if not in vi mode
	if test "$fish_key_bindings" = "fish_vi_key_bindings"
		or test "$fish_key_bindings" = "fish_hybrid_key_bindings"
		switch $fish_bind_mode
			case default
				echo -n '[N]'
			case insert
				echo -n '[I]'
			case replace-one
				echo -n '[R]'
			case visual
				echo -n '[V]'
		end

		echo -n ' '
	end

	# VCS prompt
	set -l vcs (__fish_vcs_prompt)
	if test -n "$vcs"
		printf "%s " (string sub -s 2 (__fish_vcs_prompt))
	end

	# PWD
	set_color $fish_color_cwd
	echo -n (prompt_pwd)
	set_color normal

	if not test $last_status -eq 0
		set_color $fish_color_error
		echo -n " $last_status"
		set_color normal
	end

	echo

	echo -n '└─ '
end

function fish_right_prompt
end

function fish_mode_prompt
end
