import wollok.game.*
import personaje.*
import bala.*
import movimientos.*
import instrucciones.*
import objects.*

class Zombie {
	var index
	var tipo // alpha - beta - delta - boss
	var property position = game.at(0,0)
	var property vidaRestante = tipo.vidaInicial();
	var property direccion = abajo
	var puedeMoverse = true
	var sonidos = new SonidosPersonaje()
	
	
	const zombieDanio = game.sound("zombieDanio.mp3")
	
	method image() = "zombie/" + tipo.str() + "/zombie-" + direccion.prefijo() + ".png"
		 
	method personajeMismoLugarQueZombie(charact) {
		return (charact.position().x() == self.position().x()) || (charact.position().y() == self.position().y())
	}
	method personajeDerechaDelZombie(charact) {
		return charact.position().x() > self.position().x();	
	}
	method personajeArribaDelZombie(charact) {
		return charact.position().y() > self.position().y();			
	}
	
	method puedoPerseguir() {
		return puedeMoverse && !self.personajeMismoLugarQueZombie(personaje)
	}
	
	method moverseX() {
  		if(self.puedoPerseguir()) {  			
	  		if(self.personajeDerechaDelZombie(personaje)){
	  			direccion = derecha
	  		} else {
	  			direccion = izquierda
	  		}	
	  		direccion.mover(1,self)		
		} else {
			self.puedeMoverse(true) 
		}
	}

	method moverseY() {
  		if(self.puedoPerseguir()) {  			
	  		if(self.personajeArribaDelZombie(personaje)){
	  			direccion = arriba
	  		} else {
	  			direccion = abajo
	  		}	
  			direccion.mover(1,self)		
		} else {
			self.puedeMoverse(true) 
		}
	}  	
  	
  	method acercarseAlPersonaje() {
  		game.schedule(500,{game.onTick(1000, "movX-" + index , { self.moverseX()})})
	    game.onTick(1000, "movY-" + index , { self.moverseY()})
  	}
  	
  	method initialize(){
		const x = 8.randomUpTo(game.width())
		const y = 5.randomUpTo(game.height())
		position = game.at(x,y)
		game.addVisual(self)
		self.acercarseAlPersonaje()  	
		self.detectarChoque()		
	}
		

	method danoRecibido(danioRecibido) {
		vidaRestante = 0.max(vidaRestante - danioRecibido) // self.danioQueHago()
		sonidos = new SonidosPersonaje(sonidito = zombieDanio)
		sonidos.reproducir()
		if(vidaRestante <= 0) {
			self.muero()
		} 
	}
	
	method muero() {
		//sonido.danio(zombieDanio)
		instrucciones.zombieMuere()
		game.removeVisual(self)
		game.removeTickEvent("movX-" + index)
		game.removeTickEvent("movY-" + index)
	}

	method detectarChoque() {
		game.whenCollideDo(self, { chocado => chocado.choqueConZombie(self)})
	}
	
	method choqueConZombie(obj) {
		direccion.mover(-1,self)
	}

	method danioQueHago() {
		return tipo.danioQueHago(vidaRestante)
	}

	method puedeMoverse(valor) {
		puedeMoverse = valor
	}
	
	method directoAbajo() {         
		position = game.at(0,0)
	}
	
	
}

object alpha {
	method vidaInicial() = 75
	method danioQueHago(vida) {
		return vida*0.4 
	}
	method str() = "alpha"
}

object beta {
	method vidaInicial() = 100
	method danioQueHago(vida) {
		return vida*0.3 
	}
	method str() = "beta"
}

object delta {
	method vidaInicial() = 200
	method danioQueHago(vida) {
		return vida*0.25 
	}
	method str() = "delta"
}
	
object boss {
	method vidaInicial() = 500
	method danioQueHago(vida) {
		return vida*0.13 
	}
	method str() = "boss"
	method muero(){
		// super()
		ganar.ganaste()
	}
}
