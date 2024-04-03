from player import Player
import pygame

def game_loop(window):
    quitting=False

    player_1 = Player(400, 250, "./img/standing.png")


    while not quitting:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                quitting=True
        
        window.fill(pygame.Color(0,0,0))
        keys_pressed = pygame.key.get_pressed()

        if keys_pressed[pygame.K_RIGHT]:
            player_1.moveRight()
        
        if keys_pressed[pygame.K_LEFT]:
            player_1.moveLeft()
        
        if keys_pressed[pygame.K_UP]:
            player_1.moveUp()
        
        if keys_pressed[pygame.K_DOWN]:
            player_1.moveDown()
        
        window.fill(pygame.Color(0,0,0))
        player_1.draw(window)
        #pygame.time.delay(20)

        
        pygame.display.update()




if __name__ == '__main__':
    pygame.init()
    window = pygame.display.set_mode(size=(1536,790))
    pygame.display.set_caption("Déplacement")
    game_loop(window)
    pygame.quit()
