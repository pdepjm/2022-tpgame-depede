import wollok.game.*
import personaje.*

object zombie{ 
	
	var property position = game.at(0,0)
	

	method image() = "zombie.jpg"
	
	method moverse() {
    const x = 0.randomUpTo(game.width()).truncate(0)
    const y = 0.randomUpTo(game.height()).truncate(0)

    position = game.at(x,y) 
  }
	
	}
 