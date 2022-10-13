import wollok.game.*
import personaje.*

const desplazamientoDisparo = 1
const movimientoEntreDesplazamiento = 200000000000

class Bala {
	var property position = personaje.position();
	var property danio = 100; // cuanto mas lejos habria que hacer que haga menos danio. estaria bueno.
	method image() = "fuego.png"
	
	method esBala() = true
	
	method disparo(posicionInicial,sentido) {
		position = posicionInicial;
		game.addVisual(self)
		// TODO: hacer objeto por direccion unificado con el personaje y el zombie
		if(sentido == "arriba") {
			game.onTick(movimientoEntreDesplazamiento, "Bala arriba", {
				self.moverBala(self.position().x(),self.position().y() + desplazamientoDisparo)
			})	
		} else if (sentido == "abajo") {
			game.onTick(movimientoEntreDesplazamiento, "Bala arriba", {
				self.moverBala(self.position().x(),self.position().y() - desplazamientoDisparo)
			})
		} else if (sentido == "izquierda") {
			game.onTick(movimientoEntreDesplazamiento, "Bala arriba", {
				self.moverBala(self.position().x()-desplazamientoDisparo,self.position().y())
			})
		} else if (sentido == "derecha") {
			game.onTick(movimientoEntreDesplazamiento, "Bala arriba", {
				self.moverBala(self.position().x()+desplazamientoDisparo,self.position().y())
			})
		}
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