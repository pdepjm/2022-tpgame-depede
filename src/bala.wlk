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
			sentido.mover(desplazamientoDisparo,self)
		})
		self.sonidoDanio()
		
	}
	
	method sonidoDanio() {
		sonido.shouldLoop(false)
		sonido.volume(0.2)
		game.schedule(1, { sonido.play()} )
	}
	
	
	method moverBala(x,y) {
		position = game.at(x,y)		
		game.schedule(400, {
			game.removeVisual(self)
			game.removeTickEvent("Disparo")
		})
	}
	
	method choqueConZombie(zombie) {
		zombie.daniar(99)
		game.removeVisual(self)
	}
}