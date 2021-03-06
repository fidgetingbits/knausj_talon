os: linux
tag: user.i3wm
-

##
# Workspaces
##
portal <number_small>: user.system_command("i3-msg workspace {number_small}")
portal ten: user.system_command("i3-msg workspace 10")
(portal flip|flipper): user.system_command("i3-msg workspace back_and_forth")
portal right: user.system_command("i3-msg workspace next")
portal left: user.system_command("i3-msg workspace prev")

##
# Windows
##
(win|window) left: user.system_command("i3-msg focus left")
(win|window) right: user.system_command("i3-msg focus right")
(win|window) up: user.system_command("i3-msg focus up")
(win|window) down: user.system_command("i3-msg focus down")
(win|window) kill: user.system_command("i3-msg kill")
(win|window) stack: user.system_command("i3-msg layout stacking")
(win|window) default: user.system_command("i3-msg layout toggle split")
(win|window) tabbed: user.system_command("i3-msg layout tabbed")
(win|window) flip: user.system_command("/home/aa/scripts/i3/i3-focus-last.py --switch")
(win|window) [focus] <digits>:
    user.system_command("/home/aa/scripts/i3/i3-nth_window_in_workspace.py $(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name') {number_small-1}")
window focus parent: user.system_command("i3-msg focus parent")
window focus child: user.system_command("i3-msg focus child")

[window] full screen: user.system_command("i3-msg fullscreen")
[window] floating toggle: user.system_command("i3-msg floating toggle")
[window] floating focus: user.system_command("i3-msg focus mode_toggle")
window center: user.system_command("i3-msg move position center")
window move left: user.system_command("i3-msg move left") 
window move right: user.system_command("i3-msg move right") 
window move up: user.system_command("i3-msg move up") 
window move down: user.system_command("i3-msg move down") 
window resize: user.system_command('i3-msg mode "resize"')
(win|window) horizontal: user.system_command("i3-msg split h")
(win|window) vertical: user.system_command("i3-msg split v")

window grow: user.i3wm_window_grow(1)
window shrink: user.i3wm_window_shrink(1)

horizontal (shell|terminal):
    user.system_command("i3-msg split h")
    user.i3wm_shell()

vertical (shell|terminal):
    user.system_command("i3-msg split v")
    user.i3wm_shell()

# XXX - like also need to match the generic talon commands (snap?)
shuffle <number_small>:  user.system_command("i3-msg move container to workspace {number_small}")
shuffle ten: user.system_command("i3-msg move container to workspace 10")
shuffle (parent|all) <number_small>: 
    user.system_command("i3-msg focus parent")
    user.system_command("i3-msg move container to workspace {number_small}")
shuffle flip: user.system_command("i3-msg move container to workspace back_and_forth")
shuffle left: user.system_command("i3-msg move left")
shuffle right: user.system_command("i3-msg move right")
shuffle up: user.system_command("i3-msg move up")
shuffle down: user.system_command("i3-msg move down")

# multi-monitor commands
# NOTE: these are flipped on purpose, because I have to trick the talon monitor
# orientation to ensure that eye tracking works on multiple monitors
shuffle screen left: user.system_command("i3-msg move container to output right")
shuffle screen right: user.system_command("i3-msg move container to output left")

[window] make scratch: user.system_command("i3-msg move scratchpad")
[(show|hide)] scratch: user.system_command("i3-msg scratchpad show")
next scratch:
    user.system_command("i3-msg scratchpad show")
    user.system_command("i3-msg scratchpad show")

# these rely on the user settings for the mod key. see i3wm.py Actions class
launch: user.i3wm_launch()
launch <user.text>:
        user.i3wm_launch()
        sleep(100ms)
        insert("{text}")
screen lock: user.i3wm_launch()

term me: user.i3wm_shell()
new test term: user.i3wm_testing_shell()

new scratch (shell|window):
    user.i3wm_shell()
    sleep(100ms)
    user.system_command("i3-msg move scratchpad")
    user.system_command("i3-msg scratchpad show")
    user.i3wm_window_grow(5)

##
# Configuration
##
i three reload: user.system_command("i3-msg reload")
i three restart: user.system_command("i3-msg restart")
