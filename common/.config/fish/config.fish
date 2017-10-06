alias l "ls -hl"

set -x PATH ~/.cargo/bin $PATH
set -x BASE16_THEME ocean

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
