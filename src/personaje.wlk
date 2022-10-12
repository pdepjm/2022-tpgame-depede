import bala.*
import wollok.game.*

object personaje{ 
	var property position = game.center()
	var property vida = 100
	var puedeDisparar = true
//	const imagenDerecha = "personaje-d.jpg"
//	const imagenIzquierda = "personaje-i.jpg"
	
	method image() = "personaje-d.jpg"

	method disparar(sentido) {
		if(puedeDisparar) {
			puedeDisparar = false
			const balita = new Bala();
			balita.disparo(self.position(),sentido);
			game.schedule(1000, { puedeDisparar = true })			
		}
	}
	
	method esBala() = false
	method esZombie() = false
	
	method inicializarTeclas() {
		keyboard.a().onPressDo({
//			self.image(imagenIzquierda)
			self.disparar("izquierda")
		});
		keyboard.w().onPressDo({self.disparar("arriba")});
		keyboard.s().onPressDo({self.disparar("abajo")});
		keyboard.d().onPressDo({
//			self.image(imagenDerecha) 
			self.disparar("derecha")
		});
//		keyboard.left().onPressDo({self.image(imagenIzquierda)})
//		keyboard.right().onPressDo({self.image(imagenDerecha)})
	}
	
	method perdiste() {
		game.removeVisual(self)
	}
	
	
	method detectarChoqueConBala() {
		game.whenCollideDo(self, { chocado =>
			chocado.daniar(50)
		})
	}
	method daniar(cuantoDanio) {
		vida = 0.max(vida - cuantoDanio)
		if(vida <= 0) {
			// muere
			self.perdiste()

		} 
	}
}
