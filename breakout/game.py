#!/usr/bin/env python3

import pygame as pg

class Game:
    def __init__(self):
        pg.init()
        self.__running = False
        screenWidth = 800
        screenHeight = 600
        self.screen = pg.display.set_mode((screenWidth,screenHeight))
        pg.display.set_caption("Breakout")
        self.clock = pg.time.Clock()
        self.spriteList = pg.sprite.Group()

        self.paddle = Paddle(100)
        self.paddle.rect.x = screenWidth/2 - self.paddle.w/2
        self.paddle.rect.y = screenHeight-50

        self.spriteList.add(self.paddle)
    def run(self):
        while self.__running:
            events = pg.event.get()
            for event in events:
                if event.type == pg.QUIT:
                    self.__running = False
                    pg.quit()
                    exit()
            
            self.spriteList.update()

            self.screen.fill((255,255,255))
            self.spriteList.draw(self.screen)

            pg.display.flip()
            self.clock.tick(60)
    def setRunning(self, running):
        self.__running = running

class Paddle(pg.sprite.Sprite):
    def __init__(self,width):
        super().__init__()

        self.w = width
        self.h = 10

        self.image = pg.Surface([self.w,self.h])
        self.image.fill((0,0,0))

        pg.draw.rect(self.image, (0,0,0), [0,0,self.w,self.h])
        self.rect = self.image.get_rect()


def main():
    game = Game()

    game.setRunning(True)
    game.run()
    pg.quit()

if __name__ == '__main__':
    main()
