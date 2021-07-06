os: linux
tag: terminal
-

###
# Packages
#
# These tags correspond to talon grammars you want to enable while you're
# running some terminal emulator on your system. See the associated talon
# files for information and links to what tools they are associated with.
###

tag(): user.buku
tag(): user.yay
tag(): user.apt
tag(): user.ghidra_server
tag(): user.nmcli
tag(): user.taskwarrior
tag(): user.timewarrior
tag(): user.make
#tag(): user.kubectl
tag(): user.tmux
tag(): user.git
tag(): user.docker
tag(): user.service_manager
tag(): user.timer_manager
tag(): user.systemd
tag(): user.pulse_audio
tag(): user.npm

# unset this if you use `bindkey -v`
tag(): user.readline
run last [command]:
    key(up)
    key(enter)
run last script:
    insert("./")
    key(up)
    key(enter)
rerun <user.text>:
    key(ctrl-r)
    insert(text)
rerun list:
    key(ctrl-r)
kill all:
    key(ctrl-c)
    
    # XXX - these are specific to certain terminals only and should move into their
    #tag(): user.file_manager
    #todo: generic tab commands
    #tag(): tabs
    
    # own <term name>.talon file
    #action(edit.find):
    #  key(ctrl-shift-f)
    #action(edit.word_left):
    #  key(ctrl-w left)
    #action(edit.word_right):
    #  key(ctrl-w right)
    #action(app.tab_open):
    #  key(ctrl-shift-t)
    #action(app.tab_close):
    #  key(ctrl-shift-w)
    #action(app.tab_next):
    #  key(ctrl-pagedown)
    #action(app.tab_previous):
    #  key(ctrl-pageup)
    #action(app.window_open):
    #  key(ctrl-shift-n)
    #go tab <number>:
    #  key("alt-{number}")
