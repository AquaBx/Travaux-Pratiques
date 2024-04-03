    def advance_state ( self , next_move ) :
        fx = 0
        fy = 0
        if next_move.left :
            self.vx -= GameConfig.SPEED / GameConfig.TICK_SPEED

        elif next_move.right :
            self.vx += GameConfig.SPEED / GameConfig.TICK_SPEED

        if next_move.jump:
            self.tick_jump += 1
            GameConfig.JUMP_SPEED = 1.3*GameConfig.SPEED

        if self.tick_jump > 0:

            fy = next_move.jump_func(self.tick_jump)
            self.vy += fy

            if self.vy + GameConfig.PLAYER_H >= GameConfig.Y_PLATEFORM :
                self.tick_jump = 0
                self.vy = GameConfig.Y_PLATEFORM - GameConfig.PLAYER_H
                GameConfig.JUMP_SPEED = 0
            else :
                self.tick_jump += 1
                

        else : 
            self.tick_jump = 0
            GameConfig.JUMP_SPEED = 0


            




            next_move = get_next_move()
        game_state.advance_state(next_move)

            def moveUp(self):
        self.posY -= Player.vitesse

    def moveDown(self):
        self.posY += Player.vitesse
    
    def moveLeft(self):
        self.posX -= Player.vitesse
    
    def moveRight(self):
        self.posX += Player.vitesse