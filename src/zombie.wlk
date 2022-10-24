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
	var direccion = abajo
	var puedeMoverse = true
	
	const danio = game.sound("zombieDanio.mp3")
	
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
			self.puedeMoverse(true) // habria que corregir esta logica/performance!!
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
			self.puedeMoverse(true) // habria que corregir esta logica/performance!!
		}
	}  	
  	
  	method acercarseAlPersonaje() {
  		game.onTick(1000, "movX-" + index + "-" + tipo, { self.moverseX() })
	    game.onTick(1000,"movY-" + index + "-" + tipo, { self.moverseY()})
  	}
  	
  	method initialize(){
  		juego.nuevoZombie()
		const x = 8.randomUpTo(game.width())
		const y = 5.randomUpTo(game.height())
		position = game.at(x,y)
		game.addVisual(self)
		self.acercarseAlPersonaje()  	
		self.detectarChoque()		
	}
		
	method desaparecer() {
		juego.zombieMuere()
		game.removeVisual(self)
		game.removeTickEvent("movX-" + index + "-" + tipo)
		game.removeTickEvent("movY-" + index + "-" + tipo)
//		danio.shouldLoop(false)
//		danio.volume(0.2)
//		game.schedule(2, { danio.play()} )
	}

	method danoRecibido() {
		vida = 0.max(vida - 60) // self.danioQueHago()
		self.sonidoDanio()
		if(vida <= 0) {
			self.desaparecer()
			personaje.puntos(personaje.puntos() + 100) 
			personaje.zombiesRestantes(personaje.zombiesRestantes() - 1)
		} 
	}
	
	method sonidoDanio() {
		danio.shouldLoop(false)
		danio.volume(0.2)
		game.schedule(2, { danio.play()} )
	}

	method detectarChoque() {
		game.whenCollideDo(self, { chocado => chocado.choqueConZombie(self)})
	}
	
	method choqueConZombie(obj) {
		self.dosPasosParaAtras()
	}
	
	method dosPasosParaAtras() {
		direccion.mover(-1,self)
	}
	
	method danioQueHago() {
		return 25.max(vida*0.6)
	}
	
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
	}	
	
	override method danioQueHago() {
		return vida*0.4
	}
	
	method atacar() {
		return null
	}
	
}

class Beta inherits Zombie {
	
	method initialize() {
		super()
		tipo = "beta"
	}	
	
	override method danioQueHago() {
		return vida*0.6
	}
	
	method atacar() {
		game.onTick(2500,"atacar-" + index + "-" + tipo, { self.soltar()})
	}
	
	method soltar() {
		
	}
	
}

class Delta inherits Zombie {
	
	method initialize() {
		super()
		tipo = "delta"
	}	
	
	override method danioQueHago() {
		return vida*0.75
	}
	
	method atacar() {
		game.onTick(2500,"atacar-" + index + "-" + tipo, { self.disparar()})
	}
	
	method disparar() {
		
	}
	
}