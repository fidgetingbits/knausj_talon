not mode: sleep
not mode: user.presentation
-
^(talent|talon) mode$:
    mode.disable("sleep")
    mode.disable("dictation")
    mode.enable("command")
    app.notify("Command Mode")
^dictation mode$:
    mode.disable("sleep")
    mode.disable("command")
    mode.enable("dictation")
    app.notify("Dictation Mode")
    user.code_clear_language_mode()
    mode.disable("user.gdb")
^presentation mode$:
    user.switcher_hide_running()
    user.history_disable()
    user.homophones_hide()
    user.help_hide()
    user.mouse_sleep()
    speech.disable()
    app.notify("Presentation Mode")
    mode.enable("user.presentation")

