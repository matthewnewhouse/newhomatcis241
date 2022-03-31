#!/usr/bin/env python3

import pygame as pg

class Game:
    def __init__(self):
        pg.init()
        self.__running = False
        self.screenWidth = 800
        self.screenHeight = 600
        self.screen = pg.display.set_mode((self.screenWidth,self.screenHeight))
        pg.display.set_caption("Breakout")
        self.clock = pg.time.Clock()
        self.spriteList = pg.sprite.Group()

        self.overlay = Overlay(3)
        self.overlay.rect.x = 0
        self.overlay.rect.y = 0

        self.paddle = Paddle(100)
        self.paddle.rect.x = self.screenWidth/2 - self.paddle.w/2
        self.paddle.rect.y = self.screenHeight-50

        self.ball = Ball()
        self.ball.rect.x = self.screenWidth/2 - self.ball.w/2
        self.ball.rect.y = self.screenHeight/2 - self.ball.h/2

        self.spriteList.add(self.overlay)
        self.spriteList.add(self.paddle)
        self.spriteList.add(self.ball)
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

            if self.ball.rect.x >= self.screenWidth:
                self.ball.velocityX*=-1
            elif self.ball.rect.x<=0:
                self.ball.velocityX*=-1
            if self.ball.rect.y >= self.screenHeight:
                self.ball.velocityY*=-1
            elif self.ball.rect.y<=0:
                self.ball.velocityY*=-1

        
            if pg.sprite.collide_mask(self.ball,self.paddle):
                self.ball.rect.x -= self.ball.velocityX
                self.ball.rect.y -= self.ball.velocityY
                self.ball.bounce()

            self.screen.fill((255,255,255))
            self.spriteList.draw(self.screen)

            pg.display.flip()
            self.clock.tick(60)
    def setRunning(self, running):
        self.__running = running

class Overlay(pg.sprite.Sprite):
    def __init__(self,lives):
        super().__init__()
        self.lives = lives
        self.score = 0

        font = pg.font.Font(None,24)
        self.image = font.render("Lives: " + str(self.lives) + "   Score: " + 
                str(self.score), 1, (50,50,50))
        self.rect = self.image.get_rect()
        pg.draw.rect(self.image,0,self.rect,1)

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

class Ball(pg.sprite.Sprite):
    def __init__(self):
        super().__init__()

        self.w = 15
        self.h = 15

        self.image = pg.Surface([self.w,self.h])
        self.image.fill((50,50,200))

        pg.draw.rect(self.image, (50,50,200), [0,0,self.w,self.h])
        self.velocityX = 3
        self.velocityY = 3

        self.rect = self.image.get_rect()

    def update(self):
        self.rect.x += self.velocityX
        self.rect.y += self.velocityY

    def bounce(self):
        #self.velocityX*=-1
        self.velocityY*=-1
        
def main():
    game = Game()

    game.setRunning(True)
    game.run()
    pg.quit()

if __name__ == '__main__':
    main()
