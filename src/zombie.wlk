import wollok.game.*
import personaje.*
import bala.*

class Zombie {
	var property position = game.at(0,0)
	var property vida = 100; // arranca con vida 100. En cero muere y desaparece.
	
	method image() = "zombie.jpg"
	
	method esZombie() = true
	
	method moverseX() {
	  	if(personaje.position().x()-self.position().x() != 0){
	  		if(personaje.position().x() >= self.position().x()){
	  			position = game.at(self.position().x() + 1,self.position().y())
	  		} else {
	  			position = game.at(self.position().x() - 1,self.position().y())
	  		}
	  	} 
	  }

	method moverseY() {
	  	if(personaje.position().y()-self.position().y() != 0){
	  		if(personaje.position().y() >= self.position().y()){
	  			position = game.at(self.position().x(),self.position().y() + 1 )
	  		} else {
	  			position = game.at(self.position().x(),self.position().y() -1)
	  		}
	  	} 
	}  	
  	
  	method acercarseAlPersonaje() {
  		game.onTick(1000, "movimiento en el eje x", { self.moverseX() })
	    game.onTick(1000,"Movimiento en el eje y", { self.moverseY()})
  	}
  	
  	method nuevoZombie(delay, numForRand){
  		game.schedule(delay*1000, {
			const x = numForRand.randomUpTo(game.width())
			const y = numForRand.randomUpTo(game.height())
  			position = game.at(x,y)
			game.addVisual(self)
			self.acercarseAlPersonaje();  			
  		})
//  		self.detectarChoqueConBala();		// PREGUNTAR
	}
	
	method desaparecer() {
		game.removeVisual(self);
	}

	method daniar(cuantoDanio) {
		if(vida - cuantoDanio <= 0) {
			// muere
			vida -= cuantoDanio
			self.desaparecer()
			// despues de x tiempo vuelve a aparecer
			// vida al 100
		} else {
			// resta
			vida -= cuantoDanio
		}
	}
	
	// PREGUNTAR PREGUNTAR PREGUNTAR PREGUNTAR PREGUNTAR PREGUNTAR PREGUNTAR PREGUNTAR
	method detectarChoqueConBala() {
		game.whenCollideDo(self, { chocado =>
			if(chocado.esBala()) {
			    self.daniar(100)			
			} else if (!chocado.esBala()) {
				// ES EL PERSONAJE
			}
		})
	}
	
	

    // position = game.at(personaje.position().x()-zombie.position().x() - 1,personaje.position().y() - zombie.position().y()-1) 
}