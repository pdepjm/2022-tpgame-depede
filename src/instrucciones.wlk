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
<<<<<<< HEAD
}

object sonido {
	// TODO: deberiamos tener el objeto sonido que maneje todo el sonido!
=======
	
	method mostrarVida() 
	{
		game.addVisual(vida)
	}
}

object  vida{
	
	method position() = game.at(2,1)
	
	method text() = "vida: " + personaje.vida() 
	method textColor()= "00FF00FF"
	
>>>>>>> 94505e3521ece3c0b3d69b416d0f0b0408c1bad6
}