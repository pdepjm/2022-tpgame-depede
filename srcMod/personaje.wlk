import bala.*
import wollok.game.*

object personaje{ 
	var property position = game.center()
	var property direccion = "w"
	var vida = 100

//	const imagenDerecha = "personaje-d.jpg"
//	const imagenIzquierda = "personaje-i.jpg"
	
	method image() = "personaje-d.jpg"

	method vida (vidaRestada) { vida = vida - vidaRestada }
	
	method esBala() = false
	method esZombie() = false
	
	method disparar() {
		const nuevaBala = new Bala()
		nuevaBala.disparo()
	}
	
	method perdiste() {
		game.removeVisual(self)
	}
	
	method recibirDanio(cuantoDanio) {
		vida = 0.max(vida - cuantoDanio)
		game.say(self, "auch me mordieron" )
		if(vida <= 0) {
			// muere
			self.perdiste()
		} 	
		}
}
