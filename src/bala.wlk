import wollok.game.*
import personaje.*
import movimientos.*
import instrucciones.*

const desplazamientoDisparo 				= 1
const movimientoEntreDesplazamientoBala 	= 200000000000

const desplazamientoBomba	 				= 2
const movimientoEntreDesplazamientoBomba 	= 1500

class ObjetosUsables {
	// TODO: agregar al diagrama que la clase es abstracta
	var property position = personaje.position().up(1)
	
	method cantidadPuntosRequeridos()
	method danio()
	method image()
	method accionarse()
	
	method eliminarme() {
		game.removeVisual(self)
	}
	
	method choqueConZombie(zombie) {
		zombie.danoRecibido(self.danio())
		self.eliminarme()
	}

}

class Bala inherits ObjetosUsables{
	var index
	const sentido 
	const disparo = game.sound("disparo.mp3")
	
	override method cantidadPuntosRequeridos() = 0
    override method danio() = 100;
	override method image() = "fuego.png"
	

	override method accionarse() {
		
		game.addVisual(self)
		game.onTick(movimientoEntreDesplazamientoBala, "disparo-"+index, {
			if (!self.fueraDeMapa()) {
				sentido.mover(desplazamientoDisparo,self)
			} else {
				self.eliminarme()		
			} 
		})
		sonido.danio(disparo)
	}
	
	override method eliminarme() {
		super()
		game.removeTickEvent("disparo-"+index)
	}

	
	method fueraDeMapa() {
		return  self.position().y() > game.height() or self.position().y() < 0 or 
			self.position().x() < 0 or self.position().x() > game.width()
	}
	
}
	
class Muro inherits ObjetosUsables{ 
	const tiempo = 6
	const sentido = personaje.direccion()
	const construccion = game.sound("construir.mp3")
	
	override method cantidadPuntosRequeridos() = 100 
	override method image() = "muro/muro-a.png"
	override method danio() = 0
	
	override method accionarse(){

		game.addVisual(self)
		game.schedule(tiempo * 1000, {
			self.eliminarme()
		})
		sonido.danio(construccion)
	}
	

	override method choqueConZombie(zombie) {
		zombie.puedeMoverse(false)
	}
	
}

class Mina inherits Muro {
 	const explosion = game.sound("explosion.mp3")
 	// TODO: ver si puede ser una variable "exploto"
	var property exploto = false

	override method danio() = 175;
	
	override method image() { 
		if(!self.exploto()){
			return "muro/mina.png"
		} else{
			return "muro/explosion.png"
			// TODO: si exploto que 500ms se borre
		}
	}
	
	override method choqueConZombie(zombie) {
		if(!self.exploto()){
			zombie.danoRecibido(self.danio())	
			self.explotar()	
		}
	}	
	
	method explotar(){
		exploto = true
		sonido.danio(explosion)
	}
}

class MuroLoco inherits Muro {
	// TODO: REVISAR BOORADO ABAJO
	// override method danio() = 0;
	override method image() = "muro/muro-a.png"
	
	method initialize() {
		super()
		self.movermeRandom(3)
	}
	
	method movermeRandom(veces) {
		veces.times({ i => self.positionRandom(i)})
	}
	
	method positionRandom(vez) {
		game.schedule(vez*1200, {
			const x = 4.randomUpTo(game.width())
			const y = 6.randomUpTo(game.height())
			position = game.at(x,y)			
		})
	}
	
	override method choqueConZombie(zombie) {
		zombie.directoAbajo()
	}
}