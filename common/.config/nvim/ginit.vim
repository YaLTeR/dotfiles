if exists('g:GtkGuiLoaded')
    call rpcnotify(1, 'Gui', 'Font', 'monospace 13')

    call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
endif
