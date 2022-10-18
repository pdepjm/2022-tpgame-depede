import wollok.game.*
import zombie.*
import personaje.*

object instrucciones {
	
	
	method crearEspacio() {
		game.width(30)
 		game.height(19)
 		game.cellSize(50)
	    game.boardGround("doom.jpg")
	}
	method agregarPersonajes(listaZombies) {
		game.addVisualCharacter(personaje)
 		5.times({ index => listaZombies.add(new Zombie() ) })
	}	
	method musica(music) {
		music.shouldLoop(true)
		music.volume(0.2)
		game.schedule(200, { music.play()} )
	}
	
	method mostrarVida() 
	{
		game.addVisual(vida)
	}
}

object  vida{
	
	method position() = game.at(2,1)
	
	method text() = "vida: " + personaje.vida() 
	method textColor()= "00FF00FF"
	
}