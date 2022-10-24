import wollok.game.*
import zombie.*
import personaje.*
import juego.*

const music = game.sound("doomMusic.mp3")
const musicInicio = game.sound("menuInicio.mp3")
const risa = game.sound("risaFinal.mp3")
//const maxZombiesVivos = 5

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
  		game.onTick(2000, "nuevoZombie", { self.agregarZombies(listaZombies) })
	}	
	
	method agregarZombies(listaZombies) {
		if(juego.zombiesVivos() <= 5) {
			if(juego.zombiesTotales() < 6) {
				listaZombies.add(new Alpha(index = juego.zombiesTotales()))				
			} else if(juego.zombiesTotales() < 12) {
				listaZombies.add(new Beta(index = juego.zombiesTotales()))
			} else {
				listaZombies.add(new Delta(index = juego.zombiesTotales()))
			}
		}
	}
	
	method musica() {
		music.shouldLoop(true)
		music.volume(0.2)
		game.schedule(200, { music.play()} )
	}
	method mostrarVida(){
		vida.mostrarVida()

		
	}
	
	method gameOver(){
		game.addVisual(self)
		game.schedule(0,{music.stop()})
		risa.volume(0.5)
		risa.play()
		
		
	}
}



object sonido {
	// TODO: deberiamos tener el objeto sonido que maneje todo el sonido!
}

object vida {
	
	method position() = game.at(2,1)	
	method text() = "Vida: " + personaje.vida() + "\n" + "Enemigos Restantes:" + personaje.zombiesRestantes() + "\n" + "Puntos:" + personaje.puntos() 
	method textColor() = "00FF00FF"
	method mostrarVida() {
		game.addVisual(self)
	}
}

object juego {
	var zombiesVivos = 0
	var zombiesTotales = 0
	
	method zombiesVivos() = zombiesVivos
	method zombiesTotales() = zombiesTotales

	method nuevoZombie() {
		zombiesVivos += 1
		zombiesTotales += 1
	}	
	
	method zombieMuere() {
		zombiesVivos -= 1
	}
}

object inicio {
	var property position = game.at(0,0)
	var listaZombies = []
	method image() = "inicio.png" 
	method mostrarInicio() {
		game.addVisual(self)
		musicInicio.shouldLoop(true)
		musicInicio.volume(0.2)
		game.schedule(200, { musicInicio.play()} )
		keyboard.enter().onPressDo { 	
			instrucciones.crearEspacio()
			instrucciones.agregarPersonajes(listaZombies)
			instrucciones.mostrarVida()
			personaje.inicializarTeclas()
			game.schedule(0,{musicInicio.stop()})
			game.removeVisual(self)
			instrucciones.musica()}
	}
	
	
}