from talon import Context, actions

ctx = Context()
ctx.matches = r"""
app:vim
and not tag: user.vim_terminal
and not tag: user.vim_command_mode
"""


@ctx.action_class("edit")
class EditActions:
    ###
    # Actions - Talon generic command implementation
    ###
    #
    # NOTE: These are provided for people that want to use the official talon
    # edit and line commands. The vim-specific commands can be used as an
    # alternative where the command names differ. See `generic_editor.talon`,
    #
    # TODO - currently the generic talon commands for things like
    # `line_commands.talon` similar or not enabled via tag by default, however the
    # underlying `edit` commands works so it should be possible to add fairly
    # easily.
    ###
    def find(text: str = None):
        actions.user.vim_normal_mode_exterm_key("/")

    def find_next():
        actions.user.vim_normal_mode_key("n")

    def word_left():
        actions.user.vim_normal_mode_key("b")

    def word_right():
        actions.user.vim_normal_mode_key("w")

    def left():
        actions.key("left")

    def right():
        actions.key("right")

    def up():
        actions.key("up")

    def down():
        actions.key("down")

    def line_start():
        actions.user.vim_normal_mode_key("^")

    def line_end():
        actions.user.vim_normal_mode_key("$")

    def file_end():
        actions.user.vim_normal_mode_key(G)

    def file_start():
        actions.user.vim_normal_mode("gg")

    def page_down():
        actions.user.vim_normal_mode_exterm_key("ctrl-f")

    def page_up():
        actions.user.vim_normal_mode_exterm_key("ctrl-b")
        # selecting (see generic_editor.talon)

    def extend_line_up():
        actions.user.vim_visual_mode("k^")

    def extend_line_down():
        actions.user.vim_visual_mode("j^")

    def extend_left():
        actions.user.vim_visual_mode("h")

    def extend_right():
        actions.user.vim_visual_mode("l")

    def extend_word_left():
        actions.user.vim_visual_mode("b")

    def extend_word_right():
        actions.user.vim_visual_mode("e")

    def select_word():
        actions.user.vim_visual_mode("e")

    def extend_line_start():
        actions.user.vim_visual_mode("^")

    def extend_line_end():
        actions.user.vim_visual_mode("$")

    def extend_file_start():
        actions.user.vim_visual_mode("gg0")

    def extend_file_end():
        actions.user.vim_visual_mode("G")

    def select_line(n: int = None):
        actions.user.vim_visual_mode("V")

    def select_all():
        actions.user.vim_normal_mode("ggVG")
        # See vim_normal.talon and vim_visual.talon for edit.extend_ commands

    def delete_word():
        actions.user.vim_normal_mode("dw")

    def indent_more():
        actions.user.vim_normal_mode(">>")

    def indent_less():
        actions.user.vim_normal_mode("<<")

    def delete_line():
        actions.user.vim_normal_mode("dd")

    def delete():
        actions.user.vim_insert_mode_key("backspace")
        # note these are for mouse/highlighted copy/paste. shouldn't be used for actual
        # vim commands

    def copy():
        actions.key("ctrl-shift-c")

    def paste():
        actions.key("ctrl-shift-v")

    def redo():
        actions.user.vim_normal_mode_key("ctrl-r")

    def undo():
        actions.user.vim_normal_mode_key("u")


@ctx.action_class("user")
class UserActions:
    def delete_word_right():
        actions.user.vim_normal_mode("dw")

    def delete_word_left():
        actions.user.vim_normal_mode("db")

    def delete_line_remaining():
        actions.user.vim_normal_mode("d$")

    def delete_line_beginning():
        actions.user.vim_normal_mode("d0")

    def line_find_forward(key: str):
        print(key)
        actions.user.vim_any_motion_mode(f"f{key}")

    def line_find_backward(key: str):
        actions.user.vim_any_motion_mode(f"F{key}")
