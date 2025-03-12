# alias ls "ls -hN --group-directories-first --color=auto"
alias ls "eza --group-directories-first"
alias l "ls -l"
alias la "l -a"

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

# flatpak autocomplete is broken with an alias
abbr --add f flatpak
alias fu  "flatpak update"
alias fi  "flatpak install"
alias fiu "flatpak install -u"

alias c "cargo"
alias cn "cargo +nightly"

alias sc  "systemctl"
alias scu "systemctl --user"

alias jc    "journalctl"
alias jcn   "journalctl --no-hostname"
alias jcnb  "journalctl --no-hostname -b"
alias jcneb "journalctl --no-hostname -eb"
alias jcnuu "journalctl --no-hostname --user-unit"

# alias v "nvim"
# alias nvim-update "nvim -u ~/.config/nvim/plugins.vim +PlugInstall +PlugUpdate +UpdateRemotePlugins +qa"

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
alias gchm   "git checkout main"
alias gcm    "git commit -m"
alias gd     "git diff"
alias gdc    "git diff --cached"
alias gf     "git fetch"
alias gfo    "git fetch origin"
alias gfu    "git fetch upstream"
alias gl     "git log"
alias glG    "git log -G"
alias glo    "git log --oneline"
alias gm     "git merge"
alias gpul   "git pull"
alias gpulo  "git pull origin"
alias gpulu  "git pull upstream"
alias gpus   "git push"
alias gpusf  "git push --force-with-lease"
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

# Link FlatHub Discord's IPC socket to the place where apps expect it
# ln -sf {app/com.discordapp.Discord,$XDG_RUNTIME_DIR}/discord-ipc-0

# Vi key bindings
# fish_vi_key_bindings

function fish_user_key_bindings
	# VSCode terminal Alt+up and down
	bind --preset \e\[1\;5A history-token-search-backward
	bind --preset \e\[1\;5B history-token-search-forward
end

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
	if not pwd | string match -qr "^($HOME/stuff/mnt/|/run/user/1000/gvfs/)"
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

# Don't define these as that currently breaks the VSCode fish integration.
#
# function fish_right_prompt
# end
#
# function fish_mode_prompt
# end
