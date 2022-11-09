import wollok.game.*
class SonidosPersonaje{
	
	var sonidito = game.sound("perrito-danio.mp3")
	
	method reproducir(){
		sonidito.volume(0.2)
		sonidito.play()
		game.schedule(2000,{sonidito.stop()})
	}
}


