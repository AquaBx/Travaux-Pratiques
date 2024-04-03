import pygame

class Player:
    vitesse = 0.5

    def __init__(self, x, y, im):
        self.posX = x
        self.posY = y
        self.image = im
    
    def draw(self, window):
        mon_image = pygame.image.load(self.image)
        window.blit(mon_image, (self.posX, self.posY, 64, 64))

    def moveUp(self):
        self.posY -= Player.vitesse

    def moveDown(self):
        self.posY += Player.vitesse
    
    def moveLeft(self):
        self.posX -= Player.vitesse
    
    def moveRight(self):
        self.posX += Player.vitesse
