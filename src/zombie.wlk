import wollok.game.*
import personaje.*

object zombie{ 
	
	method position() = game.at(0,0) 
	method image() = "zombie.jpg"
	
	method acercarse(personaje) = game.position() - personaje.jugadorPosicion()
	}
 