import wollok.game.*
import personaje.*
import bala.*
import movimientos.*

class Zombie {
	var index
	var property position = game.at(0,0)
	var property vida = 100;
	var direccion = derecha
	var puedeMoverse = true
	
	const danio = game.sound("zombieDanio.mp3")
	
	method image() = "zombie-"+direccion.prefijo()+".jpg"
		
	method personajeMismoLugarQueZombie(charact) {
		return (charact.position().x() == self.position().x()) || (charact.position().y() == self.position().y())
	}
	method personajeDerechaDelZombie(charact) {
		return charact.position().x() > self.position().x();	
	}
	method personajeArribaDelZombie(charact) {
		return charact.position().y() > self.position().y();			
	}
	
	method puedoPerseguir() {
		return puedeMoverse && !self.personajeMismoLugarQueZombie(personaje)
	}
	
	method moverseX() {
  		if(self.puedoPerseguir()) {  			
	  		if(self.personajeDerechaDelZombie(personaje)){
	  			direccion = derecha
	  		} else {
	  			direccion = izquierda
	  		}	
	  		direccion.mover(1,self)		
		} else {
			self.puedeMoverse(true) // habria que corregir esta logica/performance!!
		}
	}

	method moverseY() {
  		if(self.puedoPerseguir()) {  			
	  		if(self.personajeArribaDelZombie(personaje)){
	  			direccion = arriba
	  		} else {
	  			direccion = abajo
	  		}	
  			direccion.mover(1,self)		
		} else {
			self.puedeMoverse(true) // habria que corregir esta logica/performance!!
		}
	}  	
  	
  	method acercarseAlPersonaje() {
  		game.onTick(1000, "movX-"+index, { self.moverseX() })
	    game.onTick(1000,"movY-"+index, { self.moverseY()})
  	}
  	
  	method initialize(){
  		game.schedule(2500, {
			const x = 8.randomUpTo(game.width())
			const y = 5.randomUpTo(game.height())
  			position = game.at(x,y)
			game.addVisual(self)
			self.acercarseAlPersonaje()  	
			self.detectarChoque()		
  		})
	}
		
	method desaparecer() {
		game.removeVisual(self)
		game.removeTickEvent("movX-"+index)
		game.removeTickEvent("movY-"+index)
		danio.shouldLoop(false)
		danio.volume(5)
		game.schedule(2, { danio.play()} )
	}

	method daniar(cuantoDanio) {
		vida = 0.max(vida - cuantoDanio)
		self.sonidoDanio()
		if(vida <= 0) {
			self.desaparecer()
		} 
	}
	
	method sonidoDanio() {
		danio.shouldLoop(false)
		danio.volume(0.2)
		game.schedule(2, { danio.play()} )
	}

	method detectarChoque() {
		game.whenCollideDo(self, { chocado => chocado.choqueConZombie(self)})
	}
	
	method choqueConZombie(obj) {
		self.dosPasosParaAtras()
	}
	
	method dosPasosParaAtras() {
		direccion.mover(-1,self)
	}
	
	method danioQueHago() {
		return vida*0.7
	}
	
	method puedeMoverse(valor) {
		puedeMoverse = valor
	}

}