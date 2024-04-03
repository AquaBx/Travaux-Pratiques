import pygame

def game_loop(window):
    quitting=False
    p_i, p_c, p_r = False, False, False

    while not quitting:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                quitting=True

        keys_pressed = pygame.key.get_pressed()
        window.fill(pygame.Color(0,0,0))

        if keys_pressed[pygame.K_c]:
            p_c = not p_c

        if keys_pressed[pygame.K_r]:
            p_r = not p_r

        if keys_pressed[pygame.K_i]:
            p_i = not p_i

        if p_c:
            pygame.draw.circle(window, pygame.Color(0,225,255), (200, 300), 50)
        
        if p_r:
            pygame.draw.rect(window, pygame.Color(225,225,0), (230,250,100,50))


        if keys_pressed[pygame.K_i]:
            mon_image = pygame.image.load("./img/standing.png")
            window.blit(mon_image, (400, 250, 64, 64))

        pygame.display.update()




if __name__ == '__main__':
    pygame.init()
    window = pygame.display.set_mode(size=(800,500))
    pygame.display.set_caption("Premier Jeu")
    game_loop(window)
    pygame.quit()
