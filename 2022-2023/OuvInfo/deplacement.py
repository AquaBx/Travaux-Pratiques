import pygame

def game_loop(window):
    quitting=False
    x = 200
    y = 300
    while not quitting:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                quitting=True
        
        window.fill(pygame.Color(0,0,0))
        keys_pressed = pygame.key.get_pressed()

        if keys_pressed[pygame.K_RIGHT]:
            x += 1
        
        if keys_pressed[pygame.K_LEFT]:
            x -=1
        
        if keys_pressed[pygame.K_UP]:
            y -=1
        
        if keys_pressed[pygame.K_DOWN]:
            y +=1
        
        pygame.draw.circle(window, pygame.Color(0,225,255), (x, y), 50)

        
        pygame.display.update()

# delai avant update : pygame.time.delay(... ms)



if __name__ == '__main__':
    pygame.init()
    window = pygame.display.set_mode(size=(1536,790))
    pygame.display.set_caption("Déplacement")
    game_loop(window)
    pygame.quit()
