import wollok.game.*
import personaje.*
import bala.*
import movimientos.*

class Zombie {
	var index
	var property position = game.at(0,0)
	var property vida = 100; // arranca con vida 100. En cero muere y desaparece.
	const danio = game.sound("zombieDanio.mp3")
	
	
	method image() = "zombie.jpg"
		
	method personajeMismoLugarQueZombie(charact) {
		return (charact.position().x() == self.position().x()) || (charact.position().y() == self.position().y())
	}
	method personajeDerechaDelZombie(charact) {
		return charact.position().x() > self.position().x();	
	}
	method personajeArribaDelZombie(charact) {
		return charact.position().y() > self.position().y();			
	}
	
	method moverseX() {
		if(!self.personajeMismoLugarQueZombie(personaje)) {
	  		if(self.personajeDerechaDelZombie(personaje)){
	  			position = derecha.mover(1,self)
	  		} else {
	  			izquierda.mover(1,self)
	  		}			
		}
	}

	method moverseY() {
	  	if(!self.personajeMismoLugarQueZombie(personaje)) {
	  		if(self.personajeArribaDelZombie(personaje)){
	  			arriba.mover(1,self)
	  		} else {
	  			abajo.mover(1,self)
	  		}			
		}
	}  	
	
	
	
//	obcjet Dereca{		
	//	mover(aquienMuevo, tiempo, distacia){
	//		game.at(aquienMuevo.left(distancia))
		//}
		
	//}
  	
  	method acercarseAlPersonaje() {
  		game.onTick(1000, "movimiento en el eje x", { self.moverseX() })
	    game.onTick(1000,"Movimiento en el eje y", { self.moverseY()})
  	}
  	
  	method initialize(){
  		game.schedule(1500, {
			const x = 8.randomUpTo(game.width())
			const y = 5.randomUpTo(game.height())
  			position = game.at(x,y)
			game.addVisual(self)
			self.acercarseAlPersonaje();  			
  		})
	}
		
	method desaparecer() {
		game.removeVisual(self)
		danio.shouldLoop(false)
		danio.volume(5)
		game.schedule(2, { danio.play()} )
		// sacar onTicks de movimiento, sino se va a buggear mucho el juego despues
	}

	method daniar(cuantoDanio) {
		vida = 0.max(vida - cuantoDanio)
		game.say(self, self.hablar())
		danio.shouldLoop(false)
		danio.volume(0.2)
		game.schedule(2, { danio.play()} )
		
		if(vida <= 0) {
			// muere
			self.desaparecer()
			// despues de x tiempo vuelve a aparecer
			// vida al 100
		} 
	}
	
	method hablar() = "auch"

	method detectarChoqueConBala() {
		game.whenCollideDo(self, { chocado => chocado.choqueConZombie(self)})
	}
	




    // position = game.at(personaje.position().x()-zombie.position().x() - 1,personaje.position().y() - zombie.position().y()-1) 
}