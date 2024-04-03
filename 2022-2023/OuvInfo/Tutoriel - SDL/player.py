import pygame

from game_config import GameConfig

class Player(pygame.sprite.Sprite):
    def __init__(self):
        self.image = GameConfig.STANDING_IMG

        self.frame_left = [ pygame.image.load( f"./Ressources/L{i}.png" ) for i in range(1,10) ]
        self.frame_right = [ pygame.image.load( f"./Ressources/R{i}.png" ) for i in range(1,10) ]

        self.tick_jump = 1

        self.px = 0
        self.py = 0
        self.ax = 0
        self.ay = 0
        self.vx = 0
        self.vy = 0

        self.anime_frame = 0



    def draw(self,window):
        if self.vx > 0:
            i = int(self.anime_frame)
            img = self.frame_right[i]
        elif self.vx < 0:
            i = int(self.anime_frame)
            img = self.frame_left[i]
        else:
            img = self.image
        
        
        window.blit(img, (self.px,self.py,GameConfig.PLAYER_W,GameConfig.PLAYER_H))


