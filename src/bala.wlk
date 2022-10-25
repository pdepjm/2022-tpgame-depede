import wollok.game.*
import personaje.*
import movimientos.*

const desplazamientoDisparo 				= 1
const movimientoEntreDesplazamientoBala 	= 200000000000

const desplazamientoBomba	 				= 2
const movimientoEntreDesplazamientoBomba 	= 1500

class ObjetosUsables{

	var property position = personaje.position().up(0.7)
	
	method cantidadPuntosRequeridos()

	
	method danio()
	method image()
	method sonido()
	method accionarse()
	
	method eliminarme() {
		game.removeVisual(self)
	}
	
	method sonidoDanio(){
		self.sonido().shouldLoop(false)
		self.sonido().volume(0.2)
		game.schedule(1, {self.sonido().play()} )
	}
	
	method choqueConZombie(zombie) {
		zombie.danoRecibido(self.danio())
		self.eliminarme()
	}

}


// EXISTE UN BUG CON LA BALA(? ENTONCES DEBERIA ELIMINARSE SI SE VA DE LA PANTALLA O A LOS 2 SEG

class Bala inherits ObjetosUsables{
	var index
	const sentido 
	
	override method cantidadPuntosRequeridos() = 0
    override method danio() = 100;
	override method sonido() = game.sound("disparo.mp3")
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
		self.sonidoDanio()
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


/* La bomba si no la toca un zombie desaparece en 6 segundos, si la toca un zombie explota */
class Bomba inherits ObjetosUsables {
	override method cantidadPuntosRequeridos() = 500
    override method danio() = 75;
	override method sonido() = game.sound("disparo.mp3")  // Necesita otro sonido
	override method image() = "bomba.png"  

	
	override method eliminarme() {
		self.explotar()
		super()
	}
	
	override method choqueConZombie(zombie) {
		self.explotar()
		super(zombie)
	}
	
	method explotar() {
		// poner gif de explosion?? como seria?
	}
	
	override method accionarse() {
		game.addVisual(self)
		game.schedule(6000, {
			self.sonidoDanio()
			self.eliminarme()
		})
	}
	
}


	
class Muro inherits ObjetosUsables{ 
	const tiempo = 6
	const sentido = personaje.direccion()
	
	override method cantidadPuntosRequeridos() = 500 
	override method sonido() {}
	override method image() = "muro/muro-a.png"
	override method danio() = 0
	
	override method accionarse(){
		// Agregar sonidito, quedaria cool :)
		game.addVisual(self)
		game.schedule(tiempo * 1000, {
			self.eliminarme()
		})
	}
	
	override method choqueConZombie(zombie) {
		zombie.puedeMoverse(false)
	}
	
}


class Mina inherits Muro {
	override method sonido() {}
	override method danio() = 75;
	override method image() = "muro/mina.png"
	
	override method choqueConZombie(zombie) {
		super(zombie) // Zombie no puede moverse
		zombie.danoRecibido(self.danio())
	}
}

class MuroLoco inherits Muro {
	
	override method sonido() {}
	override method danio() = 0;
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