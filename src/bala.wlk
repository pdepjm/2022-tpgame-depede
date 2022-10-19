import wollok.game.*
import personaje.*
import movimientos.*

const desplazamientoDisparo 				= 1
const movimientoEntreDesplazamientoBala 	= 200000000000

const desplazamientoBomba	 				= 2
const movimientoEntreDesplazamientoBomba 	= 1500

class Bala {
	var index
	var property position = personaje.position();
	var property danio = 75; 
	const sonido = game.sound("disparo.mp3")
	method image() = "fuego.png"
	
	
	method disparo(posicionInicial,sentido) {
		position = posicionInicial;
		game.addVisual(self)
		game.onTick(movimientoEntreDesplazamientoBala, "disparo-"+index, {
			if (!self.fueraDeMapa()) {
				sentido.mover(desplazamientoDisparo,self)
			} else {
				self.eliminarme()		
			} 
		})
		self.sonidoDanio()
	}
	
	method eliminarme() {
		game.removeVisual(self)
		game.removeTickEvent("disparo-"+index)
	}
	
	method fueraDeMapa() {
		return  self.position().y() > game.height() or self.position().y() < 0 or 
			self.position().x() < 0 or self.position().x() > game.width()
	}
	
	method sonidoDanio() {
		sonido.shouldLoop(false)
		sonido.volume(0.2)
		game.schedule(1, { sonido.play()} )
	}
	

	method choqueConZombie(zombie) {
		zombie.danoRecibido(danio)
		self.eliminarme()
	}
	
	method bajarDanio(cuantoDanio) {
		// cuanto mas lejos habria que hacer que haga menos danio.
		danio -= cuantoDanio
	}
}

class Bomba inherits Bala {
	
	method image() = "bomba.png"
	
	override method eliminarme() {
		self.explotar()
		super()
	}
	
	override method choqueConZombie(zombie) {
		self.explotar()
		self.bajarDanio(20)
		super(zombie)
	}
	
	method explotar() {
		// poner gif de explosion?? como seria?
	}
	
	method disparo(posicionInicial,sentido) {
		position = posicionInicial;
		game.addVisual(self)
		game.onTick(movimientoEntreDesplazamientoBomba, "disparo-"+index, {
			if (!self.fueraDeMapa()) {
				sentido.mover(desplazamientoBomba,self)
			} else {
				self.eliminarme()		
			} 
		})
		self.sonidoDanio()
	}
	
}