from talon import Context, Module, registry, ui, speech_system, scope

ctx = Context()
mod = Module()

@mod.action_class
class module_actions:
    def debug_active_context():
        """dump out the active contexts"""
        print(registry.active_contexts())

    def debug_lost_context():
        """TODO: Docstring for debug_lost_context.
        :returns: TODO

        """
        print("-------DEBUG LOST CONTEXT START-------")
        print(scope.data)
        print(registry.last_active_contexts)
        print(ui.active_app())
        print(ui.active_window())
        print(registry.commands)
        print(speech_system.engine.engine.cfg_blobs)
        print("-------DEBUG LOST CONTEXT END-------")
        pass
