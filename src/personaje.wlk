// herencia: Personajes, niveles. Ir cambiando y evolucionando.
// vida con imagenes que cambien!! -> cero necesario, no le dan bola a eso.

import bala.*
import movimientos.*
import instrucciones.*
import wollok.game.*
import muro.*

object personaje { 
	var disparosHechos = 0
	var property position = game.center()
	var property vida = 100
	var direccion = derecha // la direccion es un objeto
	var puedeDisparar = true
	const danio = game.sound("perrito-danio.mp3")

	method image() = "personaje/personaje-" + direccion.prefijo()+".png"

	method direccion() = return direccion

	method disparar() {
		if(puedeDisparar) {
			disparosHechos++
			puedeDisparar = false
			const balita = new Bala(index = disparosHechos);
			balita.disparo(self.position().up(0.7),direccion);
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
		instrucciones.gameOver()
	}
	
	method danoRecibido(cuantoDanio) {
		vida = 0.max(vida - cuantoDanio)
		self.sonidoDanio()
		if(vida <= 0) {
			self.perdiste()
		}
	}
	
	method sonidoDanio() {
		danio.shouldLoop(false)
		danio.volume(0.2)
		game.schedule(2, { danio.play()} )
	}
	
	method choqueConZombie(zombie) {
		self.danoRecibido(zombie.danioQueHago())
	}
}


