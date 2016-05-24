import scrollphat
import time
import os

class Lights:
    def __init__(self):
        scrollphat.set_brightness(2)

    def hide(self):
        scrollphat.clear()
        scrollphat.update()

    def show(self):
        for y in range(5):
            for x in range(11):
                scrollphat.set_pixel(x,y,1)
                scrollphat.update()

    def cleanup(self):
        scrollphat.clear()
        scrollphat.update()

