import re

from talon import Context, Module, actions, settings, clip

mod = Module()
ctx = Context()
ctx.matches = r"""
mode: command
and tag: user.python

mode: command
and code.language: python
"""
ctx.lists["user.code_functions"] = {
    "enumerate": "enumerate",
    "integer": "int",
    "length": "len",
    "list": "list",
    "print": "print",
    "range": "range",
    "set": "set",
    "split": "split",
    "string": "str",
    "update": "update",
    "help": "help",
}

ctx.lists["user.code_libraries"] = {
    "click": "click",
    "docker": "docker",
    "funk tools": "functools",
    "get pass": "getpass",
    "import lib": "importlib",
    "jason": "json",
    "os": "os",
    "path lib": "pathlib",
    "pea expect": "pexpect",
    "pretty print": "pprint",
    "random": "random",
    "reg ex": "re",
    "shell utils": "shutil",
    "string": "string",
    "system": "sys",
    "tar file": "tarfile",
    "time": "time",
    "trace back": "trace",
    "unit test": "unittest",
    "warnings": "warnings",
}


"""a set of fields used in python docstrings that will follow the
reStructuredText format"""
docstring_fields = {
    "class": ":class:",
    "function": ":func:",
    "parameter": ":param:",
    "param": ":param:",
    "raise": ":raise:",
    "returns": ":return:",
    "type": ":type:",
    "return type": ":rtype:",
    # these are sphinx-specific
    "see also": ".. seealso:: ",
    "notes": ".. notes:: ",
    "warning": ".. warning:: ",
    "todo": ".. todo:: ",
}

mod.list("python_docstring_fields", desc="python docstring fields")
ctx.lists["user.python_docstring_fields"] = docstring_fields

type_list = {
    "boolean": "bool",
    "integer": "int",
    "string": "str",
    "none": "None",
    "dick": "Dict",
    "float": "float",
    "any": "Any",
    "tuple": "Tuple",
    "union": "UnionAny",
    "iterable": "Iterable",
    "vector": "Vector",
    "bytes": "bytes",
    "sequence": "Sequence",
    "callable": "Callable",
    "list": "List",
    "no return": "NoReturn",
}

mod.list("python_type_list", desc="python types")
ctx.lists["user.python_type_list"] = type_list

exception_list = [
    "BaseException",
    "SystemExit",
    "KeyboardInterrupt",
    "GeneratorExit",
    "Exception",
    "StopIteration",
    "StopAsyncIteration",
    "ArithmeticError",
    "FloatingPointError",
    "OverflowError",
    "ZeroDivisionError",
    "AssertionError",
    "AttributeError",
    "BufferError",
    "EOFError",
    "ImportError",
    "ModuleNotFoundError",
    "LookupError",
    "IndexError",
    "KeyError",
    "MemoryError",
    "NameError",
    "UnboundLocalError",
    "OSError",
    "BlockingIOError",
    "ChildProcessError",
    "ConnectionError",
    "BrokenPipeError",
    "ConnectionAbortedError",
    "ConnectionRefusedError",
    "ConnectionResetError",
    "FileExistsError",
    "FileNotFoundError",
    "InterruptedError",
    "IsADirectoryError",
    "NotADirectoryError",
    "PermissionError",
    "ProcessLookupError",
    "TimeoutError",
    "ReferenceError",
    "RuntimeError",
    "NotImplementedError",
    "RecursionError",
    "SyntaxError",
    "IndentationError",
    "TabError",
    "SystemError",
    "TypeError",
    "ValueError",
    "UnicodeError",
    "UnicodeDecodeError",
    "UnicodeEncodeError",
    "UnicodeTranslateError",
    "Warning",
    "DeprecationWarning",
    "PendingDeprecationWarning",
    "RuntimeWarning",
    "SyntaxWarning",
    "UserWarning",
    "FutureWarning",
    "ImportWarning",
    "UnicodeWarning",
    "BytesWarning",
    "ResourceWarning",
]
mod.list("python_exception", desc="python exceptions")
ctx.lists["user.python_exception"] = {
    " ".join(re.findall("[A-Z][^A-Z]*", exception)).lower(): exception
    for exception in exception_list
}

decorator_list = ["classmethod", "property", "staticmethod"]
mod.list("python_decorator", desc="python decorator")
ctx.lists["user.python_decorator"] = {
    " ".join(re.findall("[A-Z][^A-Z]*", decorator)).lower(): decorator
    for decorator in decorator_list
}


@mod.capture(rule="{self.python_type_list}")
def python_type_list(m) -> str:
    "Returns a string"
    return m.python_type_list


@mod.capture(rule="{self.python_docstring_fields}")
def python_docstring_fields(m) -> str:
    "Returns a string"
    return m.python_docstring_fields


@ctx.action_class("user")
class user_actions:
    def code_insert_function(text: str, selection: str):
        if selection:
            text = text + "({})".format(selection)
        else:
            text = text + "()"
        actions.user.paste(text)
        actions.edit.left()

    def code_default_function(text: str):
        actions.user.code_public_function(text)

    def code_private_function(text: str):
        """Inserts private function declaration"""
        result = "def _{}():".format(
            actions.user.formatted_text(
                text, settings.get("user.code_private_function_formatter")
            )
        )

        actions.user.paste(result)
        actions.edit.left()
        actions.edit.left()

    def code_public_function(text: str):
        result = "def {}():".format(
            actions.user.formatted_text(
                text, settings.get("user.code_public_function_formatter")
            )
        )
        actions.user.paste(result)
        actions.edit.left()
        actions.edit.left()

    def code_insert_library(text: str, selection: str):
        actions.user.paste(f"import {text}")


@mod.action_class
class module_actions:
    # TODO this could go somewhere else
    def insert_cursor(text: str):
        """Insert a string. Leave the cursor wherever [|] is in the text"""
        if "[|]" in text:
            end_pos = text.find("[|]")
            s = text.replace("[|]", "")
            actions.insert(s)
            actions.key(f"left:{len(s) - end_pos}")
        else:
            actions.insert(text)

    def insert_cursor_paste(text1: str, text2: str):
        """Insert a string, . Leave the cursor after text1"""
        if "[|]" in text1:
            end_pos = text1.find("[|]")
            text1 = text1.replace("[|]", "")
        else:
            end_pos = len(text1)
        s = text1 + clip.get() + text2
        actions.insert(s)
        actions.key(f"left:{len(s) - end_pos}")
