from talon import Context, actions, clip

ctx = Context()
ctx.matches = r"""
win.title: /VIM MODE:v/
win.title: /VIM MODE:V/
"""


@ctx.action_class("edit")
class EditActions:
    # the distinction in visual motives that we assume that there is already a
    # selection, so when we're extending a selection in the opposite direction
    # (backwards) we want a prefix an o beforehand so that it actually extends,
    # rather than changing directions.

    def extend_line_up():
        actions.user.vim_visual_mode("ok^o")

    def extend_line_down():
        actions.user.vim_visual_mode("j^")

    def extend_left():
        actions.user.vim_visual_mode("oho")

    def extend_right():
        actions.user.vim_visual_mode("l")

    def extend_word_left():
        actions.user.vim_visual_mode("obo")

    def extend_word_right():
        actions.user.vim_visual_mode("e")

    def select_word():
        actions.user.vim_visual_mode("e")

    def extend_line_start():
        actions.user.vim_visual_mode("o^o")

    def extend_line_end():
        actions.user.vim_visual_mode("$")

    def extend_file_start():
        actions.user.vim_visual_mode("ogg0o")

    def extend_file_end():
        actions.user.vim_visual_mode("G")
        # XXX - This should be a callable function so we can do things like:
        #       '.swap on this <highlight motion>'
        #       'swap between line x, y'
        # assumes visual mode

    def selected_text():
        actions.user.vim_visual_mode("y")
        actions.user.vim_visual_mode("gv")
        return clip.get()
