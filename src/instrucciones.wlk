import wollok.game.*
import zombie.*
import personaje.*

object instrucciones {
	var property position = game.at(0,0)
	method image() = "game-over.jpg"
	
	method crearEspacio() {
		game.width(30)
 		game.height(19)
 		game.cellSize(50)
	    game.boardGround("doom.jpg")
	}
	method agregarPersonajes(listaZombies) {
		game.addVisualCharacter(personaje)
 		5.times({ index => listaZombies.add(new Zombie(index = index) ) })
	}	
	method musica(music) {
		music.shouldLoop(true)
		music.volume(0.2)
		game.schedule(200, { music.play()} )
	}
	method mostrarVida(){
		vida.mostrarVida()
	}
	
	method gameOver(){
		game.addVisual(self)
	}
}

object sonido {
	// TODO: deberiamos tener el objeto sonido que maneje todo el sonido!
}

object vida {
	
	method position() = game.at(2,1)
	
	method text() = "vida: " + personaje.vida() 
	method textColor() = "00FF00FF"

	method mostrarVida() {
		game.addVisual(self)
	}
}