# alias ls "ls -hN --group-directories-first --color=auto"
alias ls "exa --group-directories-first"
alias l "ls -l"

alias mkdir "mkdir -p"
alias mv "mv -i"

alias p    "pacman"
alias pU   "sudo pacman -U"
alias pq   "pacman -Q"
alias pqi  "pacman -Qi"
alias pql  "pacman -Ql"
alias pr   "sudo pacman -Rscn"
alias pss  "pacman -Ss"
alias psy  "sudo pacman -Sy"
alias psyu "sudo pacman -Syu"

alias pa   "pacaur -S"
alias pas  "pacaur -Ss"

alias v "nvim"
alias nvim-update "nvim -u ~/.config/nvim/plugins.vim +PlugInstall +PlugUpdate +UpdateRemotePlugins +qa"

alias g      "git"
alias ga     "git add"
alias gap    "git add -p"
alias gau    "git add -u"
alias gb     "git branch"
alias gbD    "git branch -D"
alias gbd    "git branch -d"
alias gc     "git commit"
alias gca    "git commit -a"
alias gcaa   "git commit -a --amend"
alias gcam   "git commit -am"
alias gch    "git checkout"
alias gchb   "git checkout -b"
alias gchm   "git checkout master"
alias gcm    "git commit -m"
alias gd     "git diff"
alias gdc    "git diff --cached"
alias gf     "git fetch"
alias gfu    "git fetch upstream"
alias gl     "git log"
alias glG    "git log -G"
alias glo    "git log --oneline"
alias gm     "git merge"
alias gpul   "git pull"
alias gpulo  "git pull origin"
alias gpulod "git pull origin develop"
alias gpulom "git pull origin master"
alias gpulu  "git pull upstream"
alias gpulud "git pull upstream develop"
alias gpulum "git pull upstream master"
alias gpus   "git push"
alias gpusf  "git push -f"
alias gpusu  "git push -u"
alias gpusuo "git push -u origin"
alias gr     "git rebase"
alias gri    "git rebase -i"
alias grm    "git remote"
alias grp    "git rev-parse"
alias gs     "git status"
alias gsh    "git show"
alias gsp    "git stash pop"
alias gst    "git stash"
alias gsu    "git submodule update"
alias gsui   "git submodule update --init"
alias gsuir  "git submodule update --init --recursive"

# Fix emoji and others rendering
set -g fish_emoji_width 2
set -g fish_cursor_insert line
set -g fish_cursor_replace_one underscore

# Initialize the gnome-keyring-daemon and set PATH
# This only happens when running through GDM which doesn't source stuff properly.
if test -z $SSH_AUTH_SOCK
	set -l gnome_keyring_vars (gnome-keyring-daemon --start)
	set -l gnome_keyring_vars_fish (echo $gnome_keyring_vars | sed -e 's/^\(.*\)$/set -x \\1;/' -e 's/=/ /')
	eval $gnome_keyring_vars_fish

	set -x PATH $PATH $HOME/.local/bin
end

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
	if not pwd | string match -qr \^$HOME/stuff/mnt/
		set -l vcs (__fish_vcs_prompt)
		if test -n "$vcs"
			printf "%s " (string sub -s 2 (__fish_vcs_prompt))
		end
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
