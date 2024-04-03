from game_config import GameConfig
from player import Player

import math

def abs(num):
    return (num ** 2) **0.5

def signe(num):
    if num == 0 : return 1
    return int(num / abs(num))

class GameState :
    def __init__(self):
        self.player = Player()
    
    def draw(self,window):
        
        window.blit(GameConfig.BACKGROUND_IMG, (0,0))

        self.player.draw(window)

    def is_over_floor(self,x,y):
        if y < GameConfig.Y_PLATEFORM - GameConfig.PLAYER_H:
            return (True,GameConfig.Y_PLATEFORM - GameConfig.PLAYER_H)
        else :
            return (False,GameConfig.Y_PLATEFORM - GameConfig.PLAYER_H)

    def update_pos( self, dt , next):

        speed = 10*GameConfig.PIXEL_METRE


        floor = self.is_over_floor(self.player.px,self.player.py)

        sens = signe(self.player.vx)

        self.player.ay = GameConfig.GRAVITE

        if floor[0]:
            self.player.vy += self.player.ay * dt
        else :
            self.player.ax = - 0.69768 * 75 * (self.player.vx**2) / (GameConfig.PIXEL_METRE**2) * sens
            vy0 =  -speed if next.flying else 0
            vx0 = -speed if next.left else speed if next.right else 0
            self.player.vy = vy0
            self.player.vx += self.player.ax * dt + vx0
            self.player.anime_frame = (self.player.anime_frame + dt)*1.1 % 9

        self.player.py += self.player.vy*dt
        self.player.py = min( self.player.py , floor[1])

        if signe(self.player.ax) == -signe(self.player.vx) or self.player.ax == 0:
            if abs(self.player.vx) < GameConfig.PIXEL_METRE and self.player.ax != 0:
                self.player.vx=0
            self.player.vx = signe(self.player.vx) * min( abs(self.player.vx) ,  speed)
        else:
            self.player.vx = 0
            self.player.anime_frame = 0
        
        self.player.px += self.player.vx * dt

