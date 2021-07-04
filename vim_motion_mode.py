from talon import Context, actions

ctx = Context()
ctx.matches = r"""
app:vim
not tag: user.vim_terminal
and not tag: user.vim_command_mode
"""


@ctx.action_class("edit")
class EditActions:
    def save():
        actions.user.vim_command_mode(":w\n")
