import wollok.game.*
import personaje.*
import movimientos.*

const desplazamientoDisparo 				= 1
const movimientoEntreDesplazamientoBala 	= 200000000000

const desplazamientoBomba	 				= 2
const movimientoEntreDesplazamientoBomba 	= 1500

class ObjetosDisparables{
	var index
	var property position = personaje.position().up(0.7)
	
	method danio()
	method image()
	method sonido()
	
	method eliminarme() {
		game.removeVisual(self)
		game.removeTickEvent("disparo-"+index)
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

class Bala inherits ObjetosDisparables{
    override method danio() = 100;
	override method sonido() = game.sound("disparo.mp3")
	override method image() = "fuego.png"


	method disparo(sentido) {
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
	
	method fueraDeMapa() {
		return  self.position().y() > game.height() or self.position().y() < 0 or 
			self.position().x() < 0 or self.position().x() > game.width()
	}
	
}


/* La bomba si no la toca un zombie desaparece en 6 segundos, si la toca un zombie explota */
class Bomba inherits Bala {
	
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
	
	override method disparo(sentido) {
		game.addVisual(self)
		game.schedule(6000, {
			self.sonidoDanio()
			self.eliminarme()
		})
	}
	
}