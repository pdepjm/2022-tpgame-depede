import wollok.game.*
import personaje.*

object zombie{ 
	
	var property position = game.at(0,0)



	method image() = "zombie.jpg"
	
	method moverseX() {

  	if(personaje.position().x()-zombie.position().x() != 0){
  		if(personaje.position().x() >= zombie.position().x()){
  			position = game.at(zombie.position().x() + 1,zombie.position().y())
  		} else {
  			position = game.at(zombie.position().x() - 1,zombie.position().y())
  		}
  	} 
  }

	method moverseY() {

  	if(personaje.position().y()-zombie.position().y() != 0){
  		if(personaje.position().y() >= zombie.position().y()){
  			position = game.at(zombie.position().x(),zombie.position().y() + 1 )
  		} else {
  			position = game.at(zombie.position().x(),zombie.position().y() -1)
  		}
  	} 
  }  	
  	

    //position = game.at(personaje.position().x()-zombie.position().x() - 1,personaje.position().y() - zombie.position().y()-1) 
  }
	

 