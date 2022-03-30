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
            keys = pg.key.get_pressed()
            if keys[pg.K_LEFT]:
                self.paddle.moveLeft(1)
            if keys[pg.K_RIGHT]:
                self.paddle.moveRight(1)
            
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
        self.speed = 10

        self.image = pg.Surface([self.w,self.h])
        self.image.fill((0,0,0))

        pg.draw.rect(self.image, (0,0,0), [0,0,self.w,self.h])
        self.rect = self.image.get_rect()
    
    def moveLeft(self, length):
        self.rect.x -= self.speed*length
        if self.rect.x < 0:
            self.rect.x = 0

    def moveRight(self, length):
        self.rect.x += self.speed*length
        if self.rect.x > (800-self.w):
            self.rect.x = 800-self.w

def main():
    game = Game()

    game.setRunning(True)
    game.run()
    pg.quit()

if __name__ == '__main__':
    main()
