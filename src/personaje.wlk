// herencia: Personajes, niveles. Ir cambiando y evolucionando.
// vida con imagenes que cambien!! -> cero necesario, no le dan bola a eso.

import bala.*
import movimientos.*
import wollok.game.*
import muro.*

object personaje { 
	var property position = game.center()
	var property vida = 100
	var direccion = derecha // la direccion es un objeto
	var puedeDisparar = true
	const danio = game.sound("perrito-danio.mp3")

<<<<<<< HEAD
	method image() = "personaje-"+direccion.prefijo()+".jpg"
=======

	method image() = "personaje/personaje-" + direccion.prefijo()+".png"
>>>>>>> 94505e3521ece3c0b3d69b416d0f0b0408c1bad6

	method direccion() = return direccion

	method disparar() {
		if(puedeDisparar) {
			puedeDisparar = false
			const balita = new Bala();
			balita.disparo(self.position(),direccion);
			game.schedule(1000, { puedeDisparar = true })			
		}
	}
	
	
	method inicializarTeclas() {
		keyboard.space().onPressDo({self.disparar()});
		keyboard.up().onPressDo({ direccion = arriba });
		keyboard.down().onPressDo({ direccion = abajo });
		keyboard.left().onPressDo({ direccion = izquierda });
		keyboard.right().onPressDo({ direccion = derecha });
		keyboard.m().onPressDo({var murito = new Muro()})
	}
	
	method perdiste() {
		game.removeVisual(self)
	}
	
	method daniar(cuantoDanio) {
		vida = 0.max(vida - cuantoDanio)
		self.sonidoDanio()
		if(vida <= 0) {
			self.perdiste()
		} else {
			// actualizar cartel de vida en pantalla
		}
	}
	
	method sonidoDanio() {
		danio.shouldLoop(false)
		danio.volume(0.2)
		game.schedule(2, { danio.play()} )
	}
	
	method choqueConZombie(zombie) {
		self.daniar(zombie.danioQueHago())
	}
}

