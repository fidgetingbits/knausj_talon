#defines the commands that sleep/wake Talon
mode: all
-
sleep all:
    user.switcher_hide_running()
    user.history_disable()
    user.homophones_hide()
    user.help_hide()
    user.mouse_sleep()
    speech.disable()
    user.engine_sleep()
    app.notify("Talon Sleep All Mode")

go to sleep:
    mode.enable("sleep")
    speech.disable()
    user.talon_sleep_callback()
    app.notify("Talon Sleep")

wake up:
    mode.disable("sleep")
    speech.enable()
    mode.enable("command")
    app.notify("Talon Awake")
    user.talon_wake_callback()