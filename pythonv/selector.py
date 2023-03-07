from rich.console import Console
from rich.text import Text
from rich.theme import Theme
from simple_term_menu import TerminalMenu

custom_theme = Theme({"success": "green", "error": "bold red"})

console = Console()

console.print("""\
[magenta]
              _ _   _   ___ _                 _ _  __       
  /\/\  _   _| | |_(_) / __\ | ___  _   _  __| (_)/ _|_   _ 
 /    \| | | | | __| |/ /  | |/ _ \| | | |/ _` | | |_| | | |
/ /\/\ \ |_| | | |_| / /___| | (_) | |_| | (_| | |  _| |_| |
\/    \/\__,_|_|\__|_\____/|_|\___/ \__,_|\__,_|_|_|  \__, |
                                                      |___/ 
[/]
""")
console.print("Welcome to [cyan]MultiCloudify[/]\n")

console.print("Please select mode:")
options = ["Repo Creator", "Terraform Generator"]
terminal_menu = TerminalMenu(options)
menu_entry_index = terminal_menu.show()

console.print("")

if menu_entry_index == 0:
    console.print("Repo Creator selected 📁", style="underline bold")
elif menu_entry_index == 1:
    console.print("Terraform generator selected 🍀", style="underline bold")



# console.print("[bold]This [cyan]is[/] some text.[/]")

# text = Text("Hello, World!")
# text.stylize("bold magenta", 0, 6)
# console.print(text)

# console = Console(theme=custom_theme)

# console.print("operation successful!", style="success")
# console.print("operation failed!", style="error")
# console.print("operation [error]Failed![/error]")

