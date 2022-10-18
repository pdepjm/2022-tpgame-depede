import wollok.game.*
import personaje.*
import movimientos.*

class Muro {
	var direccion = personaje.direccion()
	var property position = personaje.position();

	method image() = "muro/muro-"+direccion.prefijo()+".png"
	
	method initialize() {
		// Agregar sonidito, quedaria cool :)
		game.addVisual(self)
		game.schedule(6000, {
			self.desaparecer()
		})
	}
	
	method desaparecer() {
		game.removeVisual(self)
	}
	
	method choqueConZombie(zombie) {
		zombie.puedeMoverse(false)
	}
	
}