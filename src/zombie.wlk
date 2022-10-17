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
	  			derecha.mover(1,self)
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
  	
  	method acercarseAlPersonaje() {
  		game.onTick(1000, "movX", { self.moverseX() })
	    game.onTick(1000,"movY", { self.moverseY()})
  	}
  	
  	method initialize(){
  		game.schedule(1500, {
			const x = 8.randomUpTo(game.width())
			const y = 5.randomUpTo(game.height())
  			position = game.at(x,y)
			game.addVisual(self)
			self.acercarseAlPersonaje()  	
			self.detectarChoqueConBala()		
  		})
	}
		
	method desaparecer() {
		game.removeVisual(self)
		game.removeTickEvent("movX")
		game.removeTickEvent("movY")
		danio.shouldLoop(false)
		danio.volume(5)
		game.schedule(2, { danio.play()} )
	}

	method daniar(cuantoDanio) {
		vida = 0.max(vida - cuantoDanio)
		self.sonidoDanio()
		if(vida <= 0) {
			self.desaparecer()
		} 
	}
	method sonidoDanio() {
		danio.shouldLoop(false)
		danio.volume(0.2)
		game.schedule(2, { danio.play()} )
	}

	method detectarChoqueConBala() {
		game.whenCollideDo(self, { chocado => chocado.choqueConZombie(self)})
	}

}