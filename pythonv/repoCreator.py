import curses
from curses import wrapper
import time

def main(stdscr):
    curses.init_pair(1, curses.COLOR_BLUE, curses.COLOR_BLACK)
    curses.init_pair(2, curses.COLOR_GREEN, curses.COLOR_MAGENTA)
    BLUE_AND_BLACK = curses.color_pair(1)
    # stdscr.clear()
    # stdscr.addstr(2, 20, "Please Select infra options", BLUE_AND_BLACK)

    for i in range(100):
        stdscr.clear()
        color = BLUE_AND_BLACK
        if i % 2 == 0:
            color = BLUE_AND_BLACK
        stdscr.addstr(f"count: {i}", color)
        stdscr.refresh()
        time.sleep(0.1)


    stdscr.getch()

wrapper(main)