from rich.console import Console
from rich.text import Text
from rich.theme import Theme
from simple_term_menu import TerminalMenu
import questionary
import os
import jinja2

# Set up Jinja2 environment
template_loader = jinja2.FileSystemLoader(searchpath="./templates")
template_env = jinja2.Environment(loader=template_loader)

directory = "../infra-tools"

custom_theme = Theme({"success": "green", "error": "bold red"})

console = Console()

folder_name = "infra-tools"
file_name = "main.tf"
path = "../" + str(folder_name)

def repoCreator():
    console.print("Repo Creator selected 📁", style="underline bold")
    options = ["AWS", "Azure", "GCP (wip)", "Done"]
    terminal_menu = TerminalMenu(options)
    awsOptions, azureOptions, gcpOptions = [''] * 3 # initialise all 3

    # select multiple providers till "done"
    menu_entry_index = 5
    while not menu_entry_index == 3:
        console.print("\nPlease select provider:")
        menu_entry_index = terminal_menu.show()
        if menu_entry_index == 0:
            awsOptions = awsOption()
        elif menu_entry_index == 1:
            azureOptions = azureOption() 
        elif menu_entry_index == 2:
            gcpOptions = gcpOption()

    confirmstart = console.input("\n[bold]start repo generation?[/] (Y/n)")
    if confirmstart.lower() == "y":
        print("Starting repo generation...")
    elif confirmstart.lower() == "n":
        print("Aborting repo generation.")
        return 
    else:
        print("Invalid input. Aborting repo generation.")
        return

    #--START CREATION--
    
    #jinja README variables
    project_name = folder_name
    #TODO: dynamically add to this structure depending on what was selected
    project_description = f"""\
    Infrastructure repository contains:
    
    {folder_name}/
        ├── aws/
        |   ├── setups/
        |   ├── modules/
        ├── azure/
        |   ├── setups/
        |   ├── modules/
        ├── gcp/
        |   ├── setups/
        |   ├── modules/
                                """
    usage_instructions = "These are instructions for using my project."
    #/README

    #create base repo
    if not os.path.exists(path):
        os.system(f"cp -r ./templates/base {path}")
    else:
        console.print("[red]Directory already exists! Please remove[/]")
        return

    #jinja render
    template = template_env.get_template("README_template.md")
    output = template.render(
        project_name=project_name,
        project_description=project_description,
        usage_instructions=usage_instructions)

    with open(os.path.join("..", folder_name, "README.md"), "w") as f:
        f.write(output)

    # create tf options
    if awsOptions:
        terraformSelector(awsOptions, 'aws') 
    if azureOptions:
        terraformSelector(azureOptions, 'azure')
    if gcpOptions:
        terraformSelector(gcpOptions, 'gcp')
        console.print("gcp tf")

def terraformSelector(options, provider):
    template = template_env.get_template(provider + "-main_template.j2")
    #TODO: maybe have an if statement to generate in either stage or prod
    #inside the template file is a for loop that iterates over options and adds whichever is in the array
    output = template.render(selected_options=options)

    with open(os.path.join("..", folder_name, provider, "stage/services", "main.tf"), "w") as f:
        f.write(output)

    #copy backend.hcl into directory
    os.system(f"cp ./templates/backend.j2 {path}/{provider}/stage/services/backend.hcl")



def awsOption():
    console.print("you have selected [cyan]AWS[/]")
    console.print("(note some options are packaged with others please check that you don't have conflicting options when deploying)", style="italic Blue") 
    options = [
        {"name": "Single EC2 (VM)", "checked": False},
        {"name": "Cluster of EC2s", "checked": False},
        {"name": "static web app", "checked": False},
    ]
    selected_options = questionary.checkbox(
        "Select options:",
        choices=options
    ).ask()
    
    return selected_options

def azureOption():
    console.print("you have selected [magenta]AZURE[/]")
    console.print("(note some options are packaged with others please check that you don't have conflicting options when deploying)", style="italic Blue") 
    options = [
        {"name": "Single Virtual Machine", "checked": False},
        {"name": "Cluster of Virtual Machines", "checked": False},
        {"name": "static web app", "checked": False},
        {"name": "blob storage", "checked": False},
    ]
    selected_options = questionary.checkbox(
        "Select options:",
        choices=options
    ).ask()

    return selected_options

# SELECTOR STARTING POINT
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


if menu_entry_index == 0:
    repoCreator()
    
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

