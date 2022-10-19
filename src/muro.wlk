import wollok.game.*
import personaje.*
import movimientos.*

class Muro {
	var tiempo = 6
	var direccion = personaje.direccion()
	var property position = personaje.position();

	method image() = "muro/muro-"+direccion.prefijo()+".png"
	
	method initialize() {
		// Agregar sonidito, quedaria cool :)
		game.addVisual(self)
		game.schedule(tiempo * 1000, {
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

class Mina inherits Muro {
	override method image() = "muro/mina.png"
	
	override method choqueConZombie(zombie) {
		super(zombie) // Zombie no puede moverse
		zombie.danoRecibido(25)
	}
}

class MuroLoco inherits Muro {
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