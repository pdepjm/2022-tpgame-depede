import wollok.game.*
import personaje.*
import movimientos.*

const desplazamientoDisparo = 1
const movimientoEntreDesplazamiento = 200000000000

class Bala {
	var property position = personaje.position();
	var property danio = 100; // cuanto mas lejos habria que hacer que haga menos danio. estaria bueno.
	method image() = "fuego.png"
	
	method disparo(posicionInicial,sentido) {
		position = posicionInicial;
		game.addVisual(self)
		// TODO: hacer objeto por direccion unificado con el personaje y el zombie
				
		game.onTick(movimientoEntreDesplazamiento, "Disparo", {
			sentido.mover(desplazamientoDisparo,self)
			// se ejecutaria: derecha.mover(desplazamiento, bala)
		})
	}
	
	method moverBala(x,y) {
		position = game.at(x,y)		
		game.schedule(400, {
			game.removeVisual(self)
			// TODO: remove onTick
		})
	}
	
	method choqueConZombie(zombie) {
		zombie.daniar(35)
		game.removeVisual(self)
	}
}