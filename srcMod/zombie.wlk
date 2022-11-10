import wollok.game.*
import personaje.*
import bala.*

class Zombie {
	var property position = game.at(0,0)
	var vida = 100; 

	method image() = "zombie.jpg"

	method esZombie() = true
	// Calculo para movimiento hacia el personaje        	
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
  	// puede ponerse un random para que se mueve en x o en y asi tarda mas y es variado
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
  		})}
	
	
	method desaparecer() {
		game.removeVisual(self)
	}

	method recibirDanio(cuantoDanio) {
		vida = 0.max(vida - cuantoDanio)
		self.hablar()
		if(vida <= 0) {
			self.desaparecer() 
			} 	
		}
	method hablar() = game.say(self, "auch" )
	
	method morderPersonaje() {
		game.whenCollideDo(self, { personaje =>
			personaje.recibirDanio(20)
		})
		}
   
}