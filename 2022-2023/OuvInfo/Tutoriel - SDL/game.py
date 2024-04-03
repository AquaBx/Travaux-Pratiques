import pygame
import time

from game_state import GameState
from move import Move
from game_config import *

def get_next_move():
    next_move = Move()
    keys = pygame.key.get_pressed()
    if keys[pygame.K_LEFT]:
        next_move.left = True
    if keys[pygame.K_RIGHT]:
        next_move.right = True
    if keys[pygame.K_UP]:
        next_move.flying = True
    return next_move


def game_loop(window):
    quitting = False
    game_state = GameState()

    pygame.font.init()
    font = pygame.font.SysFont('Cascadia Mono Regular', 20)

    while not quitting:
        time0 = time.time()

        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                quitting = True


        game_state.draw(window)

        time1 = time.time()
        delta = time1-time0

        game_state.update_pos(delta, get_next_move()) 

        text_surface = font.render( f"fps : { int( 1/delta )            }", False, (0, 0, 0))
        window.blit(text_surface,(5,550))
        text_surface = font.render( f"ms  : { int(delta*10000)/10       }", False, (0, 0, 0))
        window.blit(text_surface,(5,570))
        text_surface = font.render( f"| px  : { int(game_state.player.px) }", False, (0, 0, 0))
        window.blit(text_surface,(155,550))
        text_surface = font.render( f"| py  : { int(game_state.player.py) }", False, (0, 0, 0))
        window.blit(text_surface,(155,570))
        text_surface = font.render( f"| vx  : { int(game_state.player.vx) }", False, (0, 0, 0))
        window.blit(text_surface,(305,550))
        text_surface = font.render( f"| vy  : { int(game_state.player.vy) }", False, (0, 0, 0))
        window.blit(text_surface,(305,570))
        text_surface = font.render( f"| ax  : { int(game_state.player.ax) }", False, (0, 0, 0))
        window.blit(text_surface,(455,550))
        text_surface = font.render( f"| ay  : { int(game_state.player.ay) }", False, (0, 0, 0))
        window.blit(text_surface,(455,570))

        pygame.display.update()


if __name__ == "__main__" :
    pygame.init()
    GameConfig.init()


    window = pygame.display.set_mode((GameConfig.WINDOW_W,GameConfig.WINDOW_H))

    pygame.display.set_caption("Avoid Bats")

    game_loop(window)
    pygame.quit()
    quit()