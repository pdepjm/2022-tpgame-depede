import wollok.game.*
import personaje.*
import movimientos.*

const desplazamientoDisparo = 1
const movimientoEntreDesplazamiento = 200000000000

class Bala {
	var index
	var property position = personaje.position();
	var property danio = 75; 
	const sonido = game.sound("disparo.mp3")
	method image() = "fuego.png"
	
	method disparo(posicionInicial,sentido) {
		position = posicionInicial;
		game.addVisual(self)
		game.onTick(movimientoEntreDesplazamiento, "disparo-"+index, {
			if (!self.fueraDeMapa()) {
				sentido.mover(desplazamientoDisparo,self)
			} else {
				self.eliminarBala()		
			} 
		})
		self.sonidoDanio()
	}
	
	method eliminarBala() {
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
		self.eliminarBala()
	}
	
	method bajarDanio(cuantoDanio) {
		// cuanto mas lejos habria que hacer que haga menos danio.
		danio -= cuantoDanio
	}
}