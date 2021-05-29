import os
import subprocess

from talon import app, imgui, ui, scripting

def monkey_notify(body="", title="", subtitle="", *kwargs):
    subprocess.Popen(
        ["notify-send.sh", "-t", "3000", "-f", "-u", "low", '"%s"' % subtitle]
    )


def monkey_focus(self, *kwargs):
    # subprocess.Popen(["i3-msg", f"'[class=\"(?]){self.name}\"] focus'"])
    if self.active_window.id == -1:
        os.system("i3-msg '[class=\"(?)%s\"] focus'" % self.name)
    else:
        os.system("i3-msg '[id=\"%s\"] focus'" % self.active_window.id)

# patch this to use dunst on i3wm
app.notify = monkey_notify

# patch this to use i3-msg on i3wm
ui.App.focus = monkey_focus



# on i3wm the pop up windows often minimize to and not inviewable size, with no
# way to actually resize them. show() auto refreshes, so is more cpu intensive,
# but does not have this problem
imgui.GUI.freeze = imgui.GUI.show
