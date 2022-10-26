import wollok.game.*
import zombie.*
import personaje.*

const music = game.sound("doomMusic.mp3")
const musicInicio = game.sound("menuInicio.mp3")
const risa = game.sound("risaFinal.mp3")
//const maxZombiesVivos = 5

object instrucciones {
	
	var zombiesRestantes = 30
	var zombiesEnPantalla = 0
	var property position = game.at(0,0)
	method image() = "game-over.jpg"
	
	method zombiesRestantes() = zombiesRestantes
	
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
		
		if(self.quedanZombiesPorMatar()) {
			
			if(zombiesEnPantalla <= 5 && personaje.vida() > 0) {
				if(zombiesRestantes > 20) {
					listaZombies.add(new Alpha(index = zombiesRestantes))
					self.agregarZombiePantalla()			
				} else if(zombiesRestantes > 10) {
					listaZombies.add(new Beta(index = zombiesRestantes))
					self.agregarZombiePantalla()
				} else {
					listaZombies.add(new Delta(index = zombiesRestantes))
					self.agregarZombiePantalla()
				}
			}
			
			} 
		else {
			game.removeTickEvent("nuevoZombie")
			var pajaro = new Boss(index = zombiesRestantes)
		}
		
	}
	
	method agregarZombiePantalla(){zombiesEnPantalla +=1}
	method zombieMuere() {
		zombiesEnPantalla -= 1
		zombiesRestantes -=  1 
		personaje.puntos(personaje.puntos() + 100) 
	}
	
	method quedanZombiesPorMatar() {
		return zombiesRestantes > 0
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
	method text() = "Vida: " + personaje.vida() + "\n" + "Enemigos Restantes:" + instrucciones.zombiesRestantes() + "\n" + "Puntos:" + personaje.puntos() 
	method textColor() = "00FF00FF"
	method mostrar() {
		game.addVisual(self)
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