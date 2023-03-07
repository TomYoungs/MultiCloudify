from rich.console import Console
from rich.text import Text
from rich.theme import Theme

custom_theme = Theme({"success": "green", "error": "bold red"})

console = Console()

console.print("this is some text.", style="bold green")

console.print("[bold]This [cyan]is[/] some text.[/]")

text = Text("Hello, World!")
text.stylize("bold magenta", 0, 6)
console.print(text)

console = Console(theme=custom_theme)

console.print("operation successful!", style="success")
console.print("operation failed!", style="error")
console.print("operation [error]Failed![/error]")

