import wollok.game.*

class Bala {
	var property position = 0;
	var property danio = 100; // cuanto mas lejos habria que hacer que haga menos danio. estaria bueno.
	method image() = "bala.png"
	
	method disparo(posicionInicial) {
		position = posicionInicial;
		game.addVisual(self)
		self.irHaciaAdelante();
	}
	
	method irHaciaAdelante() {
		
	}
}