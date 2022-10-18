import wollok.game.*
import personaje.*
import movimientos.*

const desplazamientoDisparo = 1
const movimientoEntreDesplazamiento = 200000000000

class Bala {
	var property position = personaje.position();
	var property danio = 100; // cuanto mas lejos habria que hacer que haga menos danio. estaria bueno.
	const sonido = game.sound("disparo.mp3")
	method image() = "fuego.png"
	
	method disparo(posicionInicial,sentido) {
		position = posicionInicial;
		game.addVisual(self)
		game.onTick(movimientoEntreDesplazamiento, "Disparo", {
			if (!self.fueraDeMapa())
			{
				sentido.mover(desplazamientoDisparo,self)
			}
			else game.removeVisual(self)
		})
		self.sonidoDanio()
		
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
		zombie.daniar(99)
		game.removeVisual(self)
	}
}