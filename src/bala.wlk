import wollok.game.*
import personaje.*

class Bala {
	var property position = personaje.position();
	var property danio = 100; // cuanto mas lejos habria que hacer que haga menos danio. estaria bueno.
	method image() = "fuego.png"
	
	method esBala() = true;
	
	method disparo(posicionInicial,sentido) {
		position = posicionInicial;
		game.addVisual(self)
		if(sentido == "arriba") {
			game.onTick(200, "Bala arriba", {
				position = game.at(self.position().x(),self.position().y() + 1)
			})	
		} else if (sentido == "abajo") {
			game.onTick(200, "Bala arriba", {
				position = game.at(self.position().x(),self.position().y() - 1)
			})
		} else if (sentido == "izquierda") {
			game.onTick(200, "Bala arriba", {
				position = game.at(self.position().x()-1,self.position().y())
			})
		} else if (sentido == "derecha") {
			game.onTick(200, "Bala arriba", {
				position = game.at(self.position().x()+1,self.position().y())
			})
		}
	}
}