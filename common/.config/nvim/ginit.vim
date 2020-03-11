if exists('g:GtkGuiLoaded')
    " Set via:
    " gsettings set org.gnome.desktop.interface monospace-font-name 'monospace 12'
    "
    " call rpcnotify(1, 'Gui', 'Font', 'monospace 12')

    call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
    NGTransparency .98 .98
endif
