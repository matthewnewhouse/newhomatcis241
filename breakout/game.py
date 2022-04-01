#!/usr/bin/env python3

import pygame as pg
import random

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

        self.brickList = pg.sprite.Group()
        for i in range(8):
            for j in range(3):
                b = Brick()
                b.rect.x = i * 100
                b.rect.y = 50 * j
                self.brickList.add(b)
                self.spriteList.add(b)

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
                self.overlay.lives-=1
                if self.overlay.lives == 0:
                    running = False
            elif self.ball.rect.y<=0:
                self.ball.velocityY*=-1
        
            if pg.sprite.collide_mask(self.ball,self.paddle):
                self.ball.rect.x -= self.ball.velocityX
                self.ball.rect.y -= self.ball.velocityY
                self.ball.bounce()

        
            brickCollision = pg.sprite.spritecollide(self.ball,self.brickList,False)
            for b in brickCollision:
                self.ball.bounce()
                self.overlay.score+=1
                b.hit()
                if b.health == 0:
                    b.kill()
                if(len(self.brickList) == 0):
                    running = False

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
        self.velocityY*=-1

class Brick(pg.sprite.Sprite):
    def __init__(self):
        super().__init__()

        r = random.randint
        self.red = r(0,255)
        self.blue = r(0,255)
        self.green = r(0,255)
        self.color = (self.red,self.blue,self.green)
        self.health = self.red + self.blue + self.green
        self.h = 50
        self.w = 100
        
        self.image = pg.Surface([self.w,self.h])
        self.image.fill(self.color)
        
        pg.draw.rect(self.image, self.color, [0,0,self.w, self.h])
        self.rect = self.image.get_rect()
    
    def hit(self):
        self.health -= 50
        if self.health <= 0:
            self.kill()
        self.red += 50/3
        self.blue += 50/3
        self.green += 50/3
        if self.red > 255:
            self.red = 255
        if self.blue > 255:
            self.blue = 255
        if self.green > 255:
            self.green = 255
        self.color = (self.red,self.blue,self.green)
        self.image = pg.Surface([self.w,self.h])
        self.image.fill(self.color)
        

def main():
    game = Game()

    game.setRunning(True)
    game.run()
    pg.quit()

if __name__ == '__main__':
    main()
