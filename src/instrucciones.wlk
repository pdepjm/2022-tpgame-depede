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
		
		if(personaje.quedanZombiesPorMatar()) {
			
			if(juego.zombiesVivos() <= 5 && personaje.vida() > 0) {
				if(juego.zombiesTotales() < 10) {
					listaZombies.add(new Alpha(index = juego.zombiesTotales()))				
				} else if(juego.zombiesTotales() < 20) {
					listaZombies.add(new Beta(index = juego.zombiesTotales()))
				} else {
					listaZombies.add(new Delta(index = juego.zombiesTotales()))
				}
			}
			
		} else  {
			game.removeTickEvent("nuevoZombie")
			var pajaro = new Boss(index = juego.zombiesTotales())
		}
		
	}
	
	method eliminarZombies(listaZombies) {
		listaZombies.forEach({zombie => {
			zombie.muero(100)
			// listaZombies.remove(zombie)
		}})
		listaZombies.removeAllSuchThat({zombie => zombie.vida() >= -100 })
	}
	
	method gameOver(){
		game.addVisual(self)
		game.schedule(0,{music.stop()})
		risa.volume(1)
		risa.play()		
	}
}

object sonido {
	method iniciarMusicaDeFondo() {
		music.shouldLoop(true)
		music.volume(0.1)
		music.play()
	}
	method danio(track) {
		track.shouldLoop(false)
		track.volume(0.2)
		game.schedule(1,{track.play()})
	}
}

object vida {
	
	method position() = game.at(2,1)	
	method text() = "Vida: " + personaje.vida() + "\n" + "Enemigos Restantes:" + personaje.zombiesRestantes() + "\n" + "Puntos:" + personaje.puntos() 
	method textColor() = "00FF00FF"
	method mostrar() {
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
	
	method zombieMuere(danioRecibido) {
		zombiesVivos -= 1
		personaje.puntos(personaje.puntos() + danioRecibido) 
		if(personaje.zombiesRestantes() > 0){
			personaje.zombiesRestantes(personaje.zombiesRestantes() - 1)
			
		}
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
		game.schedule(2, { musicInicio.play()} )
		
		keyboard.enter().onPressDo { self.comenzar() }
	}
	
	method comenzar() {
		instrucciones.crearEspacio()
		instrucciones.agregarPersonajes(listaZombies)
		vida.mostrar()
		personaje.inicializarTeclas()
		game.schedule(0,{musicInicio.stop()})
		game.removeVisual(self)
		sonido.iniciarMusicaDeFondo()
	}		
}

object ganar {
	var property position = game.at(0,0)
	const musicaFinal = game.sound("credits.mp3")
	method image() = "game-winner.jpg"
	
	method ganaste(){
		game.addVisual(self)
		game.schedule(0,{music.stop()})
		sonido.danio(musicaFinal)		
		
	}
	
}