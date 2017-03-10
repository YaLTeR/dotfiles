alias l "ls -hl"

# Vi key bindings
fish_vi_key_bindings

# Base16 Shell
if status --is-interactive
	eval sh $HOME/.config/base16-shell/scripts/base16-ashes.sh
end

function fish_prompt
	set -l last_status $status

	echo -n '┌ '

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
	# VCS prompt
	#printf "%s " (__fish_vcs_prompt)

	# Vi mode indicator
	# Do nothing if not in vi mode
	if test "$fish_key_bindings" = "fish_vi_key_bindings"
		or test "$fish_key_bindings" = "fish_hybrid_key_bindings"
		switch $fish_bind_mode
			case default
				echo '[N]'
			case insert
				echo '[I]'
			case replace-one
				echo '[R]'
			case visual
				echo '[V]'
		end
	end
end

function fish_mode_prompt
end
