import pygame
from player import Player

class super_player(Player):

    def accelere():
        Player.vitesse = min(20, Player.vitesse)
    
    def decelere():
        Player.vitesse = max(0, Player.vitesse)
    
    def draw(self, window):
        pygame.draw.rect(window, pygame.Collor(255,0,0), (self.posX, self.posY, 64, 64))
        super().draw(window)
