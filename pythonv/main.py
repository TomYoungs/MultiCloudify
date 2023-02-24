import sys

def say_hi():
    print('hi!')


def add_these(x, y):
    print(x + y)

args = sys.argv[1:]
if args:
    function_name = args[0]
    if function_name == say_hi.__name__:
        say_hi()
    elif function_name == add_these.__name__:
        if not len(args) == 3:
            print('Missing args')
        else:
            x, y = int(args[1]), int(args[2])
            add_these(x, y)
else:
    print('No args passed in')