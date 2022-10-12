import wollok.game.*
import personaje.*

class Bala {	
	var property position = personaje.position()
	var direccion_bala = personaje.direccion() 
	var danio = 100; // cuanto mas lejos habria que hacer que haga menos danio. estaria bueno.
	method image() = "fuego.png"
	method esBala() = true

	
	method disparo() {
		game.addVisual(self)
		game.onTick(50, "Disparo", { 
			if (direccion_bala == "w") {  position = game.at(self.position().x(),		self.position().y() + 1 ) self.impacto() }
			if (direccion_bala == "s") {  position = game.at(self.position().x(),		self.position().y() - 1 ) self.impacto() }
			if (direccion_bala == "d") {  position = game.at(self.position().x() + 1,	self.position().y())  self.impacto() }
			if (direccion_bala == "a") {  position = game.at(self.position().x() - 1,	self.position().y())  self.impacto() }
	
		})}
	
	// Reviso siempre si mi posicion impacta con un zombie o contra la pared fuera del limite(faltante!!!), si es asi desaparezco
	method impacto() {
		game.whenCollideDo(self, { zombie =>
			game.removeVisual(self)
			zombie.recibirDanio(50)
			zombie.hablar()
			    })
		}
	
		
	
}