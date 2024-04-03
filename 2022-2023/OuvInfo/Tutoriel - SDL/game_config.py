import pygame

class GameConfig :
    WINDOW_H = 640
    WINDOW_W = 960
    Y_PLATEFORM = 516
    PLAYER_W = 64
    PLAYER_H = 64

    SPEED = 26 # 1m/s

    PIXEL_METRE = 26 # 1m = 26 pixels 
    GRAVITE = 9.81 * PIXEL_METRE
    
    TICK_SPEED = 1/240

    def init():
        GameConfig.BACKGROUND_IMG = pygame.image.load("./Ressources/background.png")
        GameConfig.STANDING_IMG = pygame.image.load( './Ressources/standing.png' )