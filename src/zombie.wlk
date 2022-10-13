import wollok.game.*
import personaje.*
import bala.*

class Zombie {
	var index
	var property position = game.at(0,0)
	var property vida = 100; // arranca con vida 100. En cero muere y desaparece.
	const danio = game.sound("zombieDanio.mp3")
	
	
	method image() = "zombie.jpg"
		
	// 
	
	method moverseX() {
		// TODO: diferencia. abstraccion
	  	if(personaje.position().x()-self.position().x() != 0){
	  		if(personaje.position().x() >= self.position().x()){
	  			position = game.at(self.position().x() + 1,self.position().y())
	  		} else {
	  			position = game.at(self.position().x() - 1,self.position().y())
	  		}
	  	} 
	  }
	  // right, left, etc en movX movY

	method moverseY() {
				
	  	if(personaje.position().y()-self.position().y() != 0){
	  		if(personaje.position().y() >= self.position().y()){
	  			position = game.at(self.position().x(),self.position().y() + 1 )
	  		} else {
	  			position = game.at(self.position().x(),self.position().y() -1)
	  		}
	  	} 
	}  	
	
	
	
//	obcjet Dereca{		
	//	mover(aquienMuevo, tiempo, distacia){
	//		game.at(aquienMuevo.left(distancia))
		//}
		
	//}
  	
  	method acercarseAlPersonaje() {
  		game.onTick(1000, "movimiento en el eje x", { self.moverseX() })
	    game.onTick(1000,"Movimiento en el eje y", { self.moverseY()})
  	}
  	
  	method initialize(){
  		game.schedule(1500, {
			const x = 8.randomUpTo(game.width())
			const y = 5.randomUpTo(game.height())
  			position = game.at(x,y)
			game.addVisual(self)
			self.acercarseAlPersonaje();  			
  		})
	}
		
	method desaparecer() {
		game.removeVisual(self)
		danio.shouldLoop(false)
		danio.volume(5)
		game.schedule(2, { danio.play()} )
		// sacar onTicks de movimiento
	}

	method daniar(cuantoDanio) {
		vida = 0.max(vida - cuantoDanio)
		game.say(self, self.hablar())
		danio.shouldLoop(false)
		danio.volume(0.2)
		game.schedule(2, { danio.play()} )
		
		if(vida <= 0) {
			// muere
			self.desaparecer()
			// despues de x tiempo vuelve a aparecer
			// vida al 100
		} 
	}
	
	method hablar() = "auch"
	// PREGUNTAR PREGUNTAR PREGUNTAR PREGUNTAR PREGUNTAR PREGUNTAR PREGUNTAR PREGUNTAR
	method detectarChoqueConBala() {
		game.whenCollideDo(self, { chocado => chocado.choqueConZombie(self)})
	}
	




    // position = game.at(personaje.position().x()-zombie.position().x() - 1,personaje.position().y() - zombie.position().y()-1) 
}