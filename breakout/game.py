#!/usr/bin/env python3
#***************************************************************
# A representation of the Breakout Game.
# There are many sprites needed, including the paddle,
# all of the balls, all of the bricks, and the game's overlay.
# Note that all game music and sound effects were found on
# Pixabay and were free to use.
#
# @author Matthew Newhouse
# @version Winter 2022, CIS 343
#**************************************************************/

#Imports:

#Pygame for game mechanics
import pygame as pg

#Random for random number generation
import random

#/**************************************************************
# Runs the main game logic and holds all of the sprites.
#**************************************************************/
class Game:

    #The Game's constructor.
    def __init__(self):
        #Initializes Pygame.
        pg.init()

        #Turns on the game.
        self.setRunning(True)

        #Loads music (Set to 5% volume, repeats)
        pg.mixer.music.load("background.ogg")
        pg.mixer.music.set_volume(.05)
        pg.mixer.music.play(-1)

        #Creates window
        self.setScreenWidth(800)
        self.setScreenHeight(600)
        self.setScreen()
        pg.display.set_caption("Breakout")

        #Creates the clock
        self.setClock(pg.time.Clock())

        #Creates the sprite list.
        self.setSpriteList(pg.sprite.Group())

        #Creates the overlay (Gives 5 Lives)
        self.setOverlay(5,self.getScreenWidth(), self.getScreenHeight())
        self.addSprite(self.getOverlay())

        #Creates the paddle (Width of 200).
        self.setPaddle(200, self.getScreenWidth(), self.getScreenHeight())
        self.addSprite(self.getPaddle())

        #Create Bricks
        self.setBrickList(pg.sprite.Group())
        self.createBricks()
        self.addSprite(self.getBrickList())

        #Create Balls
        self.setBallList(pg.sprite.Group())
        self.addBall()

        #Create cooldown for adding balls when 'space' is pressed.
        self.setAddBallTime(pg.time.get_ticks())
        self.setAddBallCoolDown(200)

    #The main logic of the game loop.
    def run(self):

        #While the game is running, sprites will be updated and user inout will be handled.
        while self.getRunning():

            #Gets player input.
            events = pg.event.get()

            #Finds the pressed keys.
            keysPressed = pg.key.get_pressed()

            #Checks if the player quits the game.
            for event in events:
                if event.type == pg.QUIT:
                    self.setRunning(False)

            #Checks if the player moves the paddle.
            if keysPressed[pg.K_LEFT]:
                self.getPaddle().moveLeft(1)
            if keysPressed[pg.K_RIGHT]:
                self.getPaddle().moveRight(1)

            #Finds the current time for calculating cooldowns.
            currTime = pg.time.get_ticks()

            #Add a ball if the player presses 'space'.
            if currTime - self.getAddBallTime() >= self.getAddBallCoolDown() and keysPressed[pg.K_SPACE]:
                self.addBall()
                self.setAddBallTime(currTime)

            #Update all sprites (and check for collisions).
            self.getSpriteList().update()

            #Check if the player wins.
            if (len(self.getBrickList()) == 0):

                #This will be the last loop.
                self.setRunning(False)

                #Show the player they have won.
                self.getOverlay().setWon(True)

                #Destroy other on-screen objects.
                self.getPaddle().kill()
                for ball in self.getBallList():
                    ball.kill()

                #Update screen.
                self.getSpriteList().update()
                self.getScreen().fill((255, 255, 255))
                self.getSpriteList().draw(self.getScreen())
                pg.display.flip()

                #Wait 3 seconds, then the game will close.
                pg.time.delay(3000)

            #Check if the player lost.
            if self.getOverlay().getLives() <= 0:

                #This will be the last loop.
                self.setRunning(False)

                #Destroy other on-screen objects.
                self.getPaddle().kill()
                for ball in self.getBallList():
                    ball.kill()
                for brick in self.getBrickList():
                    brick.kill()

                #Update the screen, including game over screen.
                self.getSpriteList().update()
                self.getScreen().fill((255, 255, 255))
                self.getSpriteList().draw(self.getScreen())
                pg.display.flip()

                #Wait 3 seconds, then the game will close.
                pg.time.delay(3000)

            #Make a white background.
            self.getScreen().fill((255, 255, 255))

            #Draw sprites on screen.
            self.getSpriteList().draw(self.getScreen())
            pg.display.flip()

            #Set clock to 60 frames.
            self.setClockTicks(60)

    #All getters and setters for game.

    #Retrieves if the game is running or not.
    def getRunning(self):
        return self.__running

    #Sets if the game is running, needs a boolean.
    def setRunning(self, running):
        self.__running = running

    #Retrieves the height of the screen.
    def getScreenHeight(self):
        return self.__screenHeight

    #Sets the height of the screen, needs an int.
    def setScreenHeight(self, height):
        self.__screenHeight = height

    #Retrieves the width of the screen.
    def getScreenWidth(self):
        return self.__screenWidth

    #Sets the width of the screen, needs an int.
    def setScreenWidth(self, width):
        self.__screenWidth = width

    #Retrieves the screen.
    def getScreen(self):
        return self.__screen

    #Sets the screen, which is set automatically from the screen width and height.
    def setScreen(self):
        self.__screen = pg.display.set_mode((self.getScreenWidth(), self.getScreenHeight()))

    #Retrieves the clock.
    def getClock(self):
        return self.__clock

    #Sets the clock, needs a clock.
    def setClock(self, clock):
        self.__clock = clock

    #Sets the clock's ticks. Needs the number of ticks to set the FPS.
    def setClockTicks(self, ticks):
        self.__clock.tick(ticks)

    #Retrieves the sprite list.
    def getSpriteList(self):
        return self.__spriteList

    #Sets the sprite list, needs a list (sprite group).
    def setSpriteList(self, list):
        self.__spriteList = list

    #Adds a sprite to the sprite list, needs a sprite to add.
    def addSprite(self, sprite):
        self.__spriteList.add(sprite)

    #Retrieves the paddle.
    def getPaddle(self):
        return self.__paddle

    #Sets the paddle, needs a paddle width and the screen's dimensions.
    def setPaddle(self, width, screenWidth, screenHeight):
        self.__paddle = Paddle(width, screenWidth, screenHeight)

    #Retrieves the ball list.
    def getBallList(self):
        return self.__ballList

    #Sets the ball list, needs a list (sprite group).
    def setBallList(self, list):
        self.__ballList = list

    #Adds a ball. (I.e. creates a ball and adds it to the sprite list)
    def addBall(self):
        newBall = Ball(self.getScreenWidth(),self.getScreenHeight(),
                       self.getPaddle(), self.getOverlay(), self.getBrickList())
        self.getBallList().add(newBall)
        self.addSprite(newBall)

    #Retrieves the last time a ball was added.
    def getAddBallTime(self):
        return self.__addBallTime

    #Sets the add ball time, needs the tick a ball was added.
    def setAddBallTime(self, ticks):
        self.__addBallTime = ticks

    #Retrieves the cooldown for adding balls.
    def getAddBallCoolDown(self):
        return self.__addBallCoolDown

    #Sets the cooldown for added balls, needs milliseconds.
    def setAddBallCoolDown(self, time):
        self.__addBallCoolDown = time

    #Retrieves the brick list.
    def getBrickList(self):
        return self.__brickList

    #Sets the brick list, needs a sprite group.
    def setBrickList(self, list):
        self.__brickList = list

    #Creates all of the bricks and adds them to the proper groups.
    def createBricks(self):

        #An 8 by 5 grid of bricks is created.
        for i in range(8):
            for j in range(5):
                b = Brick()
                b.setX(i*100)
                b.setY(j*50)
                self.getBrickList().add(b)
                self.addSprite(b)

    #Retrives the overlay.
    def getOverlay(self):
        return self.__overlay

    #Sets the overlay, needs the amount of lives and screen dimensions.
    def setOverlay(self, lives, screenWidth, screenHeight):
        self.__overlay = Overlay(lives, screenWidth, screenHeight)


#/**************************************************************
# Represents the overlay on the screen to show lives,
# the score, and various messages.
#**************************************************************/
class Overlay(pg.sprite.Sprite):

    #The Overlay's constructor. Needs an amount of lives and the screen dimensions.
    def __init__(self, lives,screenWidth, screenHeight):

        #Initializes the sprite.
        super().__init__()

        #Sets the lives, score, game state, screen width and height.
        self.setLives(lives)
        self.setScore(0)
        self.setWon(False)
        self.setScreenWidth(screenWidth)
        self.setScreenHeight(screenHeight)

        #Creates initial text to display.
        self.makeText()

        #Positions and draws overlay on the screen.
        self.setRect(self.getImage().get_rect())
        self.setX(0)
        self.setY(self.getScreenHeight()-20)
        pg.draw.rect(self.getImage(), 0, self.getRect(), 1)

    #Overrides the Sprite update method
    def update(self):

        #Creates current text for game state.
        self.makeText()

        #Gets the current rect.
        self.setRect(self.image.get_rect())

        #If the player has won...
        if self.getWon():
            #Position winning message in the middle.
            self.setX(self.getScreenWidth()/2 - self.rect.width/2)
            self.setY(self.getScreenHeight()/2)
        #If the player hasn't won or lost.
        elif self.getLives()>0:
            #Position game info in bottom left corner.
            self.setX(0)
            self.setY(self.getScreenHeight()-20)
        #Else, the player has lost...
        else:
            # Position game over message in the middle.
            self.setX(self.getScreenWidth()/2 - self.rect.width/2)
            self.setY(self.getScreenHeight()/2)

        #Draw the overlay.
        pg.draw.rect(self.getImage(), 0, self.getRect(), 1)

    #Creates the text for the overlay based on the game state.
    def makeText(self):

        #If the player has won...
        if self.getWon():
            #Make 'YOU WIN' message.
            font = pg.font.Font(None, 80)
            self.setImage(font.render("YOU WIN!", True, (50, 50, 50)))
        #If the player hasn't won or lost...
        elif self.getLives() > 0:
            #Create string of instructions/score/lives
            font = pg.font.Font(None, 22)
            self.setImage(font.render("Arrow Keys To Move Paddle, Hold Space For More Balls | Score: "
                                 + str(self.getScore()) +  " | Lives: " + str(self.getLives()), True, (50, 50, 50)))
        # Else, the player has lost...
        else:
            #Show 'GAME OVER' message.
            font = pg.font.Font(None, 80)
            self.setImage(font.render("GAME OVER", True, (50, 50, 50)))

    #All getters and setters for Overlay.

    #Retrieves the number of lives.
    def getLives(self):
        return self.__lives

    #Sets the number of lives, integer needed.
    def setLives(self, num):
        self.__lives = num

    #Decrements the number of lives.
    def decrementLives(self):
        self.__lives-=1

    #Retrieves the game score.
    def getScore(self):
        return self.__score

    #Sets the game score, needs an integer.
    def setScore(self, score):
        self.__score = score

    #Increments the game score.
    def incrementScore(self):
        self.__score+=1

    #Retrieves a boolean of if the player has won or not.
    def getWon(self):
        return self.__won

    #Sets if the player has won of not, needs a bool.
    def setWon(self, bool):
        self.__won = bool

    #Retrieves the screen height.
    def getScreenHeight(self):
        return self.__screenHeight

    #Sets the screen height, needs an integer.
    def setScreenHeight(self, height):
        self.__screenHeight = height

    #Retrieves the screen width.
    def getScreenWidth(self):
        return self.__screenWidth

    #Sets the screen width, needs an int.
    def setScreenWidth(self, width):
        self.__screenWidth = width

    #Retrieves the x position of the overlay.
    def getX(self):
        return self.getRect().x

    #Sets the x position of the overlay, needs an x value.
    def setX(self, x):
        self.getRect().x = x

    #Retrieves the y position of the overlay.
    def getY(self):
        return self.getRect().y

    #Sets the y position of the overlay, needs a y value.
    def setY(self, y):
        self.getRect().y = y

    #Retrieves the rect.
    def getRect(self):
        return self.rect

    #Sets the rect, needs a rect.
    def setRect(self, rect):
        self.rect = rect

    #Retrieves the image.
    def getImage(self):
        return self.image

    #Sets the image, needs an image.
    def setImage(self, image):
        self.image = image

#/**************************************************************
# #Represents the paddle sprite for the game, including
# movement, speed, positioning, and collisions.
#**************************************************************/
class Paddle(pg.sprite.Sprite):

    #The Paddle's constructor. Needs a width and the screen dimensions.
    def __init__(self, width, screenWidth, screenHeight):

        #Initializes the sprite attributes.
        super().__init__()

        #Sets the width, height, speed, screen width and height.
        self.setWidth(width)
        self.setHeight(10)
        self.setSpeed(12)
        self.setScreenWidth(screenWidth)
        self.setScreenHeight(screenHeight)

        #Makes image for paddle.
        self.setImage(pg.Surface([self.getWidth(), self.getHeight()]))
        self.getImage().fill((0, 0, 0))

        #Makes and draws rect for paddle.
        pg.draw.rect(self.getImage(), (0, 0, 0), [0, 0, self.getWidth(), self.getHeight()])
        self.setRect(self.getImage().get_rect())

        #Sets the paddle in the middle of the screen at the bottom.
        self.setX(self.getScreenWidth() / 2 - self.getWidth() / 2)
        self.setY(self.getScreenHeight() - 50)

    #Moves the paddle left.
    def moveLeft(self, length):

        #Movement based on length and speed.
        self.setX(self.getX()- (self.getSpeed() * length))

        #Can't go past left edge of the screen.
        if self.getX() < 0:
            self.setX(0)

    #Moves the paddle right.
    def moveRight(self, length):

        #Movement based on length and speed.
        self.setX(self.getX()+ (self.getSpeed() * length))

        #Can't go past right edge of the screen.
        if self.getX() > (self.getScreenWidth() - self.getWidth()):
            self.setX(self.getScreenWidth() - self.getWidth())

    #All getters and setters for the paddle.

    #Retrieves the paddle width.
    def getWidth(self):
        return self.__width

    #Sets the paddle width, needs an integer.
    def setWidth(self, width):
        self.__width = width

    #Retrieves the paddle height.
    def getHeight(self):
        return self.__height

    #Sets the paddle height, needs an integer.
    def setHeight(self,height):
        self.__height = height

    #Retrieves the paddle speed.
    def getSpeed(self):
        return self.__speed

    #Sets the paddle speed, needs an integer.
    def setSpeed(self, speed):
        self.__speed = speed

    #Retrieves the paddle's x position.
    def getX(self):
        return self.getRect().x

    #Sets the paddle's x position, needs an x value.
    def setX(self, x):
        self.getRect().x = x

    #Retrieves the paddle's y position.
    def getY(self):
        return self.getRect().y

    #Sets the paddle's y position, needs a y value.
    def setY(self, y):
        self.getRect().y = y

    #Retrieves the screen height.
    def getScreenHeight(self):
        return self.__screenHeight

    #Sets the screen height, needs an int.
    def setScreenHeight(self, height):
        self.__screenHeight = height

    #Retrieves the screen width.
    def getScreenWidth(self):
        return self.__screenWidth

    #Sets the screen width, needs an int.
    def setScreenWidth(self, width):
        self.__screenWidth = width

    #Retrieves the rect.
    def getRect(self):
        return self.rect

    #Sets the rect, needs a rect.
    def setRect(self, rect):
        self.rect = rect

    #Retrieves the image.
    def getImage(self):
        return self.image

    #Sets the image, needs an image.
    def setImage(self, image):
        self.image = image

#/**************************************************************
# Represents the ball sprite in the game including movement,
# positioning, bouncing, sounds, collisions, etc.
#**************************************************************/
class Ball(pg.sprite.Sprite):

    #The Ball's constructor. Needs the screen dimensions, the paddle, overlay, and bricklist.
    def __init__(self, screenWidth,screenHeight, paddle, overlay, brickList):

        #Initializes the Sprite attributes.
        super().__init__()

        #Sets the screen width and height.
        self.setScreenWidth(screenWidth)
        self.setScreenHeight(screenHeight)

        #The paddle, overlay, and brick list are needed for collision detection and logic.
        self.setPaddle(paddle)
        self.setOverlay(overlay)
        self.setBrickList(brickList)

        #Sets the size of the ball.
        self.setWidth(20)
        self.setHeight(20)

        #Creates a random color for the ball.
        rand = random.randint
        self.setRed(rand(30, 255))
        self.setBlue(rand(30, 255))
        self.setGreen(rand(30, 255))
        self.setColor((self.getRed(),self.getBlue(),self.getGreen()))

        #Gets the image of the ball.
        self.setImage(pg.Surface([self.getWidth(), self.getHeight()]))
        self.getImage().fill((255, 255, 255))
        self.getImage().set_colorkey((255, 255, 255))

        #Gets the circle for the ball, NOT a rect.
        pg.draw.circle(self.getImage(), self.getColor(), (self.getWidth() / 2,
                                                          self.getHeight() / 2), self.getWidth() / 2)

        #Sets the initial velocity of the ball.
        self.setVelocityX(2)
        self.setVelocityY(2)

        #Used to make the ball go faster (but not too fast).
        self.setAddedSpeed(.05)
        self.setMaxSpeed(5)

        #Inherited from Pygame, so not private here.
        self.setRect(self.getImage().get_rect())

        #Sets the ball's position.
        self.setX(self.getScreenWidth() / 2 - self.getWidth() / 2)
        self.setY(self.getScreenHeight() / 2 - self.getHeight() / 2)

        #Needed to calculate time between bounces,
        #which is useful for stopping possible glitches and
        #collision oddities.
        self.setBounceTime(pg.time.get_ticks())
        self.setBounceCoolDown(30)

        #Sets the sound effects for the ball.
        self.setDeathBoom()
        self.setBounceBoom()

    #Overrides the update method for sprites.
    def update(self):

        #Moves the ball based on current velocity.
        self.setX(self.getX()+self.getVelocityX())
        self.setY(self.getY()+self.getVelocityY())

        #Checking for ball collisions (with screen edges).
        #Ussually means respective velocities are flipped and a sound is played.
        #Collision with right edge...
        if self.getX() >= self.getScreenWidth():
            self.flipVelocityX()
            self.getBounceBoom().play()
        #Collision with left edge...
        elif self.getX() <= 0:
            self.flipVelocityX()
            self.getBounceBoom().play()
        #Collision with bottom edge...
        if self.getY() >= self.getScreenHeight():
            self.flipVelocityY()

            #Take away a life for losing a ball.
            #Instead of killing a ball and making a new one,
            #this one is just recycled to the starting point
            #and given the initial velocity, though a death sound does play.
            self.getOverlay().decrementLives()
            self.getDeathBoom().play()
            self.setX(self.getScreenWidth() / 2 - self.getWidth() / 2)
            self.setY(self.getScreenHeight() / 2 - self.getHeight() / 2)
            self.setVelocityX(2)
            self.setVelocityY(2)

        #Collision with top edge...
        elif self.getY() <= 0:
            self.flipVelocityY()
            self.getBounceBoom().play()

        #Checks for collision with the paddle.
        if pg.sprite.collide_mask(self, self.getPaddle()):
            self.bounce()
            self.getBounceBoom().play()

        #Checking for brick collisions.
        brickCollisions = pg.sprite.spritecollide(self, self.getBrickList(), False)

        #Possible for ball to collide with multiple bricks per frame.
        for brick in brickCollisions:

            #Current time used to stop excessive bouncing.
            currTime = pg.time.get_ticks()

            #If a bounce is allowed...
            if currTime - self.getBounceTime() >= self.getBounceCoolDown():

                #Flips velocities and bounces to simulate ball bouncing physics.
                if self.getVelocityY() > 0:
                    self.flipVelocityX()
                self.bounce()

                #Resets bounce cooldown.
                self.setBounceTime(currTime)

                #A brick was hit, so the score is incremented.
                self.getOverlay().incrementScore()
                brick.hit()
                brick.getHitBoom().play()

            #If the brick dies, it is removed from the game.
            if brick.getHealth() == 0:
                brick.kill()

    #Simulates the bouncing of a ball.
    def bounce(self):

        #Used to simulate randomness.
        r = random.randint

        #50/50 chance the ball gets faster in the X or Y direction.
        #The speed in either direction can't exceed the max speed.
        if r(0,1):
            if self.getMaxSpeed() > self.getVelocityX() > -1 * self.getMaxSpeed():
                if self.getVelocityX() > 0:
                    self.setVelocityX(self.getVelocityX()+self.getAddedSpeed())
                else:
                    self.setVelocityX(self.getVelocityX()-self.getAddedSpeed())
        else:
            if self.getMaxSpeed() > self.getVelocityY() > -1 * self.getMaxSpeed():
                if self.getVelocityY() > 0:
                    self.setVelocityY(self.getVelocityY()+self.getAddedSpeed())
                else:
                    self.setVelocityY(self.getVelocityY()+-self.getAddedSpeed())

        #The bouncing occurs.
        self.flipVelocityY()

    #All getters and setters for the balls.

    #Retrieves the width of the ball.
    def getWidth(self):
        return self.__width

    #Sets the width of the ball, needs an integer.
    def setWidth(self, width):
        self.__width = width

    #Retrieves the height of the ball.
    def getHeight(self):
        return self.__height

    #Sets the height of the ball, needs an integer.
    def setHeight(self, height):
        self.__height = height

    #Retrieves the x position of the ball.
    def getX(self):
        return self.getRect().x

    #Sets the x position of the ball, needs an x value.
    def setX(self, x):
        self.getRect().x = x

    #Retrieves the y position of the ball.
    def getY(self):
        return self.getRect().y

    #Sets the y position of the ball, needs a y value.
    def setY(self, y):
        self.getRect().y = y

    #Retrieves the horizontal velocity of the ball.
    def getVelocityX(self):
        return self.__velocityX

    #Sets the horizontal velocity of the ball, needs an integer.
    def setVelocityX(self, x):
        self.__velocityX = x

    #Flips the horizontal velocity of the ball.
    def flipVelocityX(self):
        self.__velocityX *= -1

    #Retrieves the vertical velocity of the ball.
    def getVelocityY(self):
        return self.__velocityY

    #Sets the vertical velocity of the ball, needs an integer.
    def setVelocityY(self, y):
        self.__velocityY = y

    #Flips the vertical velocity of the ball.
    def flipVelocityY(self):
        self.__velocityY *= -1

    #Retrieves the last time there was a bounce.
    def getBounceTime(self):
        return self.__bounceTime

    #Sets the last time there was a bounce.
    def setBounceTime(self, time):
        self.__bounceTime = time

    #Retrieves the bounce cooldown.
    def getBounceCoolDown(self):
        return self.__bounceCoolDown

    #Sets the bounce cooldown time.
    def setBounceCoolDown(self, cooldown):
        self.__bounceCoolDown = cooldown

    #Retrieves the red value of the ball's color.
    def getRed(self):
        return self.__red

    #Sets the ball's red color value.
    def setRed(self, red):
        self.__red = red

    #Retrieves the blue value of the ball's color.
    def getBlue(self):
        return self.__blue

    #Sets the ball's blue color value.
    def setBlue(self, blue):
        self.__blue = blue

    #Retrieves the green value of the ball's color.
    def getGreen(self):
        return self.__green

    #Sets the ball's green color value.
    def setGreen(self, green):
        self.__green = green

    #Retrieves the ball's color value.
    def getColor(self):
        return self.__color

    #Sets the ball's color value.
    def setColor(self, color):
        self.__color = color

    #Retrieves the ball's death sound.
    def getDeathBoom(self):
        return self.__deathBoom

    #Sets the ball's death sound.
    def setDeathBoom(self):
        self.__deathBoom = pg.mixer.Sound("death.ogg")
        self.__deathBoom.set_volume(.05)

    #Retrieves the ball's bounce sound.
    def getBounceBoom(self):
        return self.__bounceBoom

    #Sets the ball's bounce sound.
    def setBounceBoom(self):
        self.__bounceBoom = pg.mixer.Sound("bounce.ogg")
        self.__bounceBoom.set_volume(.01)

    #Retrieves the screen's height.
    def getScreenHeight(self):
        return self.__screenHeight

    #Sets the screen's height, needs an integer.
    def setScreenHeight(self, height):
        self.__screenHeight = height

    #Retrieves the screen's width.
    def getScreenWidth(self):
        return self.__screenWidth

    #Sets the screen's width, needs an integer.
    def setScreenWidth(self, width):
        self.__screenWidth = width

    #Retrieves the game's paddle (used for collision detection).
    def getPaddle(self):
        return self.__paddle

    #Sets the paddle, needs a paddle.
    def setPaddle(self, paddle):
        self.__paddle = paddle

    #Retrieves the overlay (Used for keeping track of lives).
    def getOverlay(self):
        return self.__overlay

    #Sets the overlay, needs an overlay.
    def setOverlay(self, overlay):
        self.__overlay = overlay

    #Retrieves the last time a ball was added.
    def getAddBallTime(self):
        return self.__addBallTime

    #Sets the last time a ball was added.
    def setAddBallTime(self, ticks):
        self.__addBallTime = ticks

    #Retrieves the brick list (used for collision detection).
    def getBrickList(self):
        return self.__brickList

    #Sets the brick list, needs a sprite group.
    def setBrickList(self, brickList):
        self.__brickList = brickList

    #Retrieves the added speed every bounce.
    def getAddedSpeed(self):
        return self.__addedSpeed

    #Sets the added speed every bounce, needs an int.
    def setAddedSpeed(self, addedSpeed):
        self.__addedSpeed = addedSpeed

    #Retrieves the max speed of the ball.
    def getMaxSpeed(self):
        return self.__maxSpeed

    #Sets the max speed of the ball, needs an int.
    def setMaxSpeed(self, maxSpeed):
        self.__maxSpeed = maxSpeed

    #Retrieves the rect.
    def getRect(self):
        return self.rect

    #Sets the rect, needs a rect.
    def setRect(self, rect):
        self.rect = rect

    #Retrieves the image.
    def getImage(self):
        return self.image

    #Sets the image, needs an image.
    def setImage(self, image):
        self.image = image

#/**************************************************************
# Represents the brick sprites including collision, color,
# health, sounds, etc.
#**************************************************************/
class Brick(pg.sprite.Sprite):

    #The Brick's constructor.
    def __init__(self):

        #Initializes the Sprite attributes.
        super().__init__()

        #Creates a random color for the brick.
        rand = random.randint
        self.setRed(rand(0, 255))
        self.setBlue(rand(0, 255))
        self.setGreen(rand(0, 255))
        self.setColor((self.getRed(), self.getBlue(), self.getGreen()))

        #The health of the brick is based on the random color.
        self.setHealth(766 - (self.getRed() + self.getBlue() + self.getGreen()))
        self.setDamage(25)

        #Sets the size of the brick.
        self.setHeight(50)
        self.setWidth(100)

        #Makes the image of the brick.
        self.setImage(pg.Surface([self.getWidth(), self.getHeight()]))
        self.getImage().fill((0, 0, 0))

        #Draws the brick.
        pg.draw.rect(self.getImage(), self.getColor(), [0, 0, self.getWidth(), self.getHeight()])
        self.setRect(self.getImage().get_rect())

        #Sets the hit sound of the brick.
        self.setHitBoom()

    #Simulates what happens to the brick when a ball hits it.
    def hit(self):

        #Subtracts health from the brick.
        self.setHealth(self.getHealth()-self.getDamage())

        #If the brick dies, it is removed from the game.
        if self.getHealth() <= 0:
            self.kill()

        #Changes the color of the brick when hit (close to white).
        self.setRed(self.getRed() + self.getDamage()/3)
        self.setBlue(self.getBlue() + self.getDamage()/3)
        self.setGreen(self.getGreen() + self.getDamage()/3)

        #Makes sure color values are not too high.
        if self.getRed() > 255:
            self.setRed(255)
        if self.getBlue() > 255:
            self.setBlue(255)
        if self.getGreen() > 255:
            self.setGreen(255)

        #Changes the brick's image to fit the new color.
        self.setColor((self.getRed(), self.getBlue(), self.getGreen()))
        self.setImage(pg.Surface([self.getWidth(), self.getHeight()]))
        self.getImage().fill((self.getColor()))

    #All of the getter and setter methods for the brick sprites.

    #Retrieves the width of the brick.
    def getWidth(self):
        return self.__width

    #Sets the width of the brick, needs an integer.
    def setWidth(self, width):
        self.__width = width

    #Retrieves the height of the brick.
    def getHeight(self):
        return self.__height

    #Sets the height of the brick, needs an integer.
    def setHeight(self, height):
        self.__height = height

    #Retrieves the x position of the brick.
    def getX(self):
        return self.getRect().x

    #Sets the x position of the brick, needs an x value.
    def setX(self, x):
        self.getRect().x = x

    #Retrieves the y position of the brick.
    def getY(self):
        return self.getRect().y

    #Sets the y position of the brick, needs a y value.
    def setY(self, y):
        self.getRect().y = y

    #Retrieves the health of the brick.
    def getHealth(self):
        return self.__health

    #Sets the health of the brick, needs an integer.
    def setHealth(self, health):
        self.__health = health

    #Retrieves the damage a brick will take when hit.
    def getDamage(self):
        return self.__damage

    #Sets the damage a brick will take when hit, needs an integer.
    def setDamage(self, damage):
        self.__damage = damage

    #Retrieves the red color value of the brick.
    def getRed(self):
        return self.__red

    #Sets the red color value of the brick, needs an integer.
    def setRed(self, red):
        self.__red = red

    #Retrieves the blue color value of the brick.
    def getBlue(self):
        return self.__blue

    #Sets the blue color value of the brick, needs an integer.
    def setBlue(self, blue):
        self.__blue = blue

    #Retrieves the green color value of the brick.
    def getGreen(self):
        return self.__green

    #Sets the green color value of the brick, needs an integer.
    def setGreen(self, green):
        self.__green = green

    #Retrieves the color of the brick.
    def getColor(self):
        return self.__color

    #Sets the color of the brick, needs a color.
    def setColor(self, color):
        self.__color = color

    #Retrieves the hit sound of the brick.
    def getHitBoom(self):
        return self.__hitBoom

    #Sets the hit sound of the brick.
    def setHitBoom(self):
        self.__hitBoom = pg.mixer.Sound("hit.ogg")
        self.__hitBoom.set_volume(.01)

    #Retrieves the rect.
    def getRect(self):
        return self.rect

    #Sets the rect, needs a rect.
    def setRect(self, rect):
        self.rect = rect

    #Retrieves the image.
    def getImage(self):
        return self.image

    #Sets the image, needs an image.
    def setImage(self, image):
        self.image = image

#The main method.
def main():

    #The game is created and starts to run.
    game = Game()
    game.run()

    #Once the game stops running, we quit pygame and exit.
    pg.quit()
    exit()

if __name__ == '__main__':
    main()
