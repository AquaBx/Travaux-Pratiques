import pygame
import sys
from OpenGL.GL import *
from pygame.locals import *

# set pygame screen
pygame.display.set_mode((960, 640), OPENGL | DOUBLEBUF)
info = pygame.display.Info()

# basic opengl configuration
glViewport(0, 0, info.current_w, info.current_h)
glDepthRange(0, 1)
glMatrixMode(GL_PROJECTION)
glMatrixMode(GL_MODELVIEW)
glLoadIdentity()
glShadeModel(GL_SMOOTH)
glClearColor(0.0, 0.0, 0.0, 0.0)
glClearDepth(1.0)
glDisable(GL_DEPTH_TEST)
glDisable(GL_LIGHTING)
glDepthFunc(GL_LEQUAL)
glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST)
glEnable(GL_BLEND)

# load texture
surf = pygame.image.load('./Ressources/background.png')
surf = pygame.transform.flip(surf, False, True)
s = pygame.image.tostring(surf, 'RGBA')

texID = glGenTextures(1)
glBindTexture(GL_TEXTURE_2D, texID)
glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST)
glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST)
glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP)
glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP)
glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 960, 640, 0, GL_RGBA, GL_UNSIGNED_BYTE, s)
glGenerateMipmap(GL_TEXTURE_2D)
glBindTexture(GL_TEXTURE_2D, 0)

# create pygame clock
MAINCLOCK = pygame.time.Clock()

# init screen
pygame.display.init()

while True:
    # get quit event
    for event in pygame.event.get():
        if event.type == QUIT:
            pygame.quit()
            sys.exit()

    # prepare to render screen
    glClear(GL_COLOR_BUFFER_BIT)
    glLoadIdentity()
    glDisable(GL_LIGHTING)
    glEnable(GL_TEXTURE_2D)
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
    glClearColor(0, 0, 0, 1.0)

    # draw texture
    glBindTexture(GL_TEXTURE_2D, texID)
    glBegin(GL_QUADS)
    glTexCoord2f(0, 0); glVertex2f(-1, -1)
    glTexCoord2f(0, 1); glVertex2f(-1, 1)
    glTexCoord2f(1, 1); glVertex2f(1, 1)
    glTexCoord2f(1, 0); glVertex2f(1, -1)
    glEnd()

    pygame.display.flip()
    MAINCLOCK.tick(60)