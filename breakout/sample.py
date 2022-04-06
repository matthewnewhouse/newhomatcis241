#!/usr/bin/env python3

import pygame as pg
import random

class Explodifier(pg.sprite.Sprite):
    def __init__(self):
        super().__init__()
        self.image = pg.Surface((64, 64))
        self.rect = self.image.get_rect()
        pg.draw.circle(self.image, (0, 101, 164), (32, 32), 32)
        self.rect.x = 400
        self.rect.y = 300

class Blah(pg.sprite.Sprite):
    explodifiers = None
    def __init__(self):
        super().__init__()
        r = random.randint
        self.image = pg.Surface((r(0,64),r(0,64)))
        self.image.fill( (r(0,255), r(0,101), r(0,164)) )
        self.rect = self.image.get_rect()
        self.rect.x = random.randint(0,800)
        self.rect.y = random.randint(0,600)
        self.velocity = [r(0,3) - 3, r(0,3) - 3]
        self.explodifiers = None
        self.boom = pg.mixer.Sound("./hit.mp3")
        self.boom.play()

    def update(self):
        self.boom.play()
        self.rect.x += self.velocity[0]
        self.rect.y += self.velocity[1]
        if self.rect.x < 0:
            self.velocity[0] = -self.velocity[0]
        if self.rect.x > 800:
            self.velocity[0] = -self.velocity[0]
        if self.rect.y < 0:
            self.velocity[1] = -self.velocity[1]
        if self.rect.y > 600:
            self.velocity[1] = -self.velocity[1]
        collisions = pg.sprite.spritecollide(self, Blah.explodifiers, False)
        if collisions:
            self.velocity[0] = 0
            self.velocity[1] = 0
            self.rect.x = -100
            self.boom.play()

    def setExplodifiers(self, explodifiers):
        self.explodifiers = explodifiers

class Game:
    def __init__(self):
        pg.init()
        self.__running = False
        self.screen = pg.display.set_mode( (800, 600) )
        self.clock = pg.time.Clock()
        self.blahs = pg.sprite.Group()
        self.exploders = pg.sprite.Group()

    def run(self):
        while self.__running:
            events = pg.event.get()
            for event in events:
                if event.type == pg.QUIT:
                    self.__running = False
                    pg.quit()
                    exit()
            # Take events
            if event.type == pg.KEYDOWN:
                if event.key == pg.K_LEFT:
                    x = 0;
                if event.key == pg.K_RIGHT:
                    x=1;
            # Update updateable objects
            self.blahs.update()
            # Redraw
            self.screen.fill( (255, 255, 255) )
            self.blahs.draw(self.screen)
            self.exploders.draw(self.screen)
            pg.display.flip()
            self.clock.tick(60)

    def setRunning(self, running):
        self.__running = running

    def addBlah(self, blah):
        self.blahs.add(blah)

    def addExplodifier(self, exploder):
        self.exploders.add(exploder)

    def getExplodifiers(self):
        return self.exploders

def main():
    game = Game()
    
    for _ in range(0,100):
        game.addBlah( Blah() )

    game.addExplodifier(Explodifier())
    Blah.explodifiers = game.getExplodifiers()
    game.setRunning(True)
    game.run()

if __name__ == '__main__':
    main()
