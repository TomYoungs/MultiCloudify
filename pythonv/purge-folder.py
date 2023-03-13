import os
folder_name = "infra-tools"
file_name = "main.tf"
path = "../../" + str(folder_name)
if os.path.exists(path):
    os.system(f"rm -r {path}")
    print(f"removed {folder_name}")
else:
    print("doesn't exist")