import wollok.game.*
import personaje.*
import bala.*
import movimientos.*
import instrucciones.*

class Zombie {
	var index
	var tipo = "alpha" // alpha - beta - delta
	var property position = game.at(0,0)
	var property vida = 100;
	var property direccion = abajo
	var puedeMoverse = true
	
	const zombieDanio = game.sound("zombieDanio.mp3")
	
	method image() = "zombie/" + tipo + "/zombie-" + direccion.prefijo()+".png"
		 
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
  		game.onTick(1000, "movX-" + index , { self.moverseX()})
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
		vida = 0.max(vida - danioRecibido) // self.danioQueHago()
		if(vida <= 0) {
			self.muero()
		} else{
			game.say(self, "me diste")
		}
	}
	
	method muero() {
		sonido.danio(zombieDanio)
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

	method danioQueHago()

	
	method puedeMoverse(valor) {
		puedeMoverse = valor
	}
	
	method directoAbajo() {         
		position = game.at(0,0)
	}
	
	
}

class Alpha inherits Zombie {
	method initialize() {
		super()
		tipo = "alpha"
		vida = 75
	}	
	
	override method danioQueHago() {
		return vida*0.4 
	}
	

}

class Beta inherits Zombie {
	
	method initialize() {
		super()
		tipo = "beta"
		vida = 100
	}	
	
	override method danioQueHago() {
		return vida*0.3 
	}
	

	
}

class Delta inherits Zombie {
	
	method initialize() {
		super()
		tipo = "delta"
		vida = 200
	}	
	
	override method danioQueHago() {
		return vida*0.25 
	}
	

}


class Boss inherits Zombie {
	method initialize() {
		super()
		tipo = "finalboss"
		vida = 500
	}	
	
	override method danioQueHago() {
		return vida*0.13 // 65 de danio
	}
	

	
	override method muero(){
		super()
		ganar.ganaste()
	}
 	
}

