#!/usr/bin/env python3

import pygame as pg

pg.init()

# set up the window

WINDOWWIDTH = 800

WINDOWHEIGHT = 600

screen = pg.display.set_mode((WINDOWWIDTH, WINDOWHEIGHT), 0, 32)

pg.display.set_caption('Breakout')
running = True;
while running:
    pg.display.flip()
