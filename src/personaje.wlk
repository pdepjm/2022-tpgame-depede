import bala.*
import wollok.game.*

object personaje{ 
	var property position = game.center()
	var property vida = 100
	method image() = "personaje.jpg"

	method disparar(sentido) {
		const balita = new Bala();
		balita.disparo(self.position(),sentido);
	}
	
	method esBala() = false
	
	method inicializarTeclas() {
		keyboard.a().onPressDo({self.disparar("izquierda")});
		keyboard.w().onPressDo({self.disparar("arriba")});
		keyboard.s().onPressDo({self.disparar("abajo")});
		keyboard.d().onPressDo({self.disparar("derecha")});
	}
	method perdiste() {
		game.removeVisual(self)
	}
	
	method daniar(cuantoDanio) {
		if(vida-cuantoDanio <= 0) {
			self.perdiste()
		} else {
			vida -= cuantoDanio
		}
	}
}
