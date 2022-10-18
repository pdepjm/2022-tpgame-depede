import wollok.game.*
import personaje.*
import movimientos.*

const desplazamientoDisparo = 1
const movimientoEntreDesplazamiento = 200000000000

class Bala {
	var property position = personaje.position();
	var property danio = 75; 
	method image() = "fuego.png"
	
	method disparo(posicionInicial,sentido) {
		position = posicionInicial;
		game.addVisual(self)
		game.onTick(movimientoEntreDesplazamiento, "Disparo", {
			sentido.mover(desplazamientoDisparo,self)
			self.bajarDanio(0.1)
		})
	}
	
	method moverBala(x,y) {
		position = game.at(x,y)		
		game.schedule(400, {
			game.removeVisual(self)
			game.removeTickEvent("Disparo")
		})
	}
	
	method choqueConZombie(zombie) {
		zombie.daniar(danio)
		game.removeVisual(self)
	}
	
	method bajarDanio(cuantoDanio) {
		// cuanto mas lejos habria que hacer que haga menos danio.
		danio -= cuantoDanio
	}
}