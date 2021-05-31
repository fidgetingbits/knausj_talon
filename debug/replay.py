import os
import pathlib
import shutil
import subprocess
from typing import List

from talon import Context, Module, actions, app, clip, imgui, settings, ui
from talon_init import TALON_HOME

ctx = Context()
mod = Module()
mod.mode("replay_picker_open")

mod.tag(
    "record_replay", desc="a tag that will enable certain replay recording commands"
)

mod.setting(
    "saved_replay_recordings_directory",
    type=str,
    default=None,
    desc="Location that you can use to store saved recordings",
)

ctx.matches = r"""
tag: user.record_replay
"""


def check_settings(f):
    """Validate settings match the expectation of having the tags set """
    def wrapper(*args):
        if settings.get("speech.record_all") != 1:
            app.notify("Recording appears to be disabled")
            return None

        if settings.get("user.saved_replay_recordings_directory") is None:
            return None
        args[0].saved_recording_directory = pathlib.Path(
            settings.get("user.saved_replay_recordings_directory")
        ).expanduser()

        return f(*args)
    return wrapper

class _RecordingReplayer(object):
    """Manages recent recordings and make them available for replay"""

    def __init__(self, count=30):
        """Specify the number of default recording to list in the picker"""
        self.gui_open = False
        self.recordings_list = []
        self.count = count
        self.recordings = pathlib.Path(TALON_HOME, "recordings/")
        self.last_saved_recording = None
        self.saved_recording_directory = None

    def last_recordings(self) -> List:
        """Checks the last number of recordings from the recording directory,
        :returns: a list of the most recent self.count recordings
        :rtype: List

        """

        list_of_files = sorted(self.recordings.iterdir(), key=os.path.getmtime)

        file_count = len(list_of_files)
        if file_count < self.count:
            return list_of_files
        else:
            return list_of_files[file_count - self.count : file_count]

    @check_settings
    def play_last(self):
        """Play the last recording (before the replay command itself)"""
        last_recordings = self.last_recordings()
        last = last_recordings[-1:][0]
        self.play_file(last)

    @check_settings
    def play_last_saved(self):
        """Play the last saved recording"""
        if self.last_saved_recording is not None:
            self.play_file(self.last_saved_recording)

    @check_settings
    def remove_last_saved(self):
        """Remove the last saved recording"""
        if self.last_saved_recording is not None:
            self.last_saved_recording.unlink(missing_ok=True)
            self.last_saved_recording = None

    @check_settings
    def play_file(self, recording: pathlib.Path):
        """Play the recording file passed in."""
        actions.speech.disable()
        # TODO - make this a python command
        subprocess.run(["mplayer", recording])
        actions.speech.enable()

    @check_settings
    def save_recording(self, index):
        """Save the recording into the defined folder"""
        # XXX - this should use a cached list from the gui, because
        # sometimes it seems out of sync
        if index == 0:
            self.recordings_list = self.last_recordings()
        file_name = pathlib.Path(self.recordings_list[index - 1])
        if self.saved_recording_directory is None:
            return None
        shutil.copy(file_name, self.saved_recording_directory)
        self.last_saved_recording = self.saved_recording_directory.joinpath(
            file_name.name
        )

        return file_name.name


main_screen = ui.main_screen()


rr = _RecordingReplayer()

def close_replay_picker():
    global rr
    gui.hide()
    actions.mode.disable("user.replay_picker_open")
    rr.gui_open = False


@imgui.open(y=0, x=main_screen.width / 2.6)
def gui(gui: imgui.GUI):
    gui.line()
    gui.text("Commands:")
    gui.text("replay <number>")
    gui.text("replay save <number>")
    gui.text("replay yank <number>")
    gui.line()
    index = 1
    global rr
    # we do this because this code is called in a refresh loop
    if not rr.gui_open:
        rr.gui_open = True
        rr.recordings_list = rr.last_recordings()

    for path in rr.recordings_list:
        gui.text(f"{index}: {path.name} ")
        index = index + 1

    if gui.button("Hide"):
        close_replay_picker()


def raise_replay_picker():
    actions.mode.enable("user.replay_picker_open")
    gui.freeze()


@mod.action_class
class Actions:
    def replay_recording_choose():
        """Opens an UI for picking a recording to replay"""
        raise_replay_picker()

    def replay_picker_hide():
        """Hides the replay_picker display"""
        close_replay_picker()

    def replay_pick(choice: int):
        """Hides the replay_picker display"""
        global rr

        rr.play_file(rr.recordings_list[choice - 1])

    def replay_save(choice: int):
        """Save the selected recording to a preconfigured directory"""
        global rr
        file_name = rr.save_recording(choice)
        if not file_name:
            return
        # XXX - whether or not to pace should be part of a setting
        clip.set_text(file_name)
        actions.edit.paste()

    def replay_save_last():
        """Save the last recording to a preconfigured directory"""
        global rr
        file_name = rr.save_recording(0)
        if not file_name:
            return
        # XXX - make this optional
        clip.set_text(file_name)

    def replay_copy_name(choice: int):
        """Copy the file name of the selected replay file"""
        global rr

        file_name = rr.recordings_list[choice - 1]
        if not file_name:
            return None
        pathlib.Path(file_name)
        clip.set_text(file_name.name)

    def replay_last_recording():
        """Insert some info from the last self.count recordings"""
        global rr
        rr.play_last()

    def replay_last_saved():
        """Insert some info from the last self.count recordings"""
        global rr
        rr.play_last_saved()

    def replay_remove_last_saved():
        """Remove the last saved recording"""
        global rr
        rr.remove_last_saved()
