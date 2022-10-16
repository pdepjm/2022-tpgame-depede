import wollok.game.*
import zombie.*

object instrucciones {
	method crearEspacio() {
		game.width(30)
 		game.height(19)
 		game.cellSize(50)
	    game.boardGround("doom.jpg")
	}
	method agregarPersonajes(listaZombies, personaje) {
		game.addVisualCharacter(personaje)
 		5.times({ index => listaZombies.add(new Zombie(index = index)) })
	}	
	method musica(music) {
		music.shouldLoop(true)
		music.volume(0.2)
		game.schedule(200, { music.play()} )
	}
}