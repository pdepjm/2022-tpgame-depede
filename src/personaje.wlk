// herencia. Personajes, niveles. Ir cambiando y evolucionando.
// vida con imagenes que cambien



import bala.*
import wollok.game.*

object personaje{ 
	var property position = game.center()
	var property vida = 100
	var direccion = "d"
	var puedeDisparar = true
	
	method image() = "personaje-"+direccion.prefijo()+".jpg"

	method disparar(sentido) {
		if(puedeDisparar) {
			puedeDisparar = false
			const balita = new Bala();
			balita.disparo(self.position(),sentido);
			game.schedule(1000, { puedeDisparar = true })			
		}
	}
	
	
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
	
	method daniar(cuantoDanio) {
		vida = 0.max(vida - cuantoDanio)
		if(vida <= 0) {
			self.perdiste()
		} else {
			// actualizar cartel de vida en pantalla
		}
	}
	method choqueConZombie(zombie) {
		self.daniar(40)
	}
}
