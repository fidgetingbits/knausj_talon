# This script is for replay recent recordings to help try to figure out audio
# errors, clipping bugs, etc. Also see replay_open.talon, and replay.py
tag: user.record_replay
-


# XXX - at support for listing the saved recordings well?
replay last (file|recording): user.replay_last_recording()
replay last saved: user.replay_last_saved()
# Remove the last saved file
replay forget last [saved]: user.replay_remove_last_saved()
replay (pick|select): user.replay_recording_choose()
replay save last: user.replay_save_last()
