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
	var property puntos = 0
	var property zombiesRestantes = 30

	method image() = "personaje/personaje-" + direccion.prefijo()+".png"

	method direccion() = return direccion
	
	method puedeDisparar() = puedeDisparar
	
	method puedeDisparar(valor) {
		puedeDisparar = valor
	}
	
	method nuevoDisparo() {
		disparosHechos++
	}
	
	method disparosHechos() = disparosHechos
	
	// DEJAR TODO ESTO ASIII!! ES PARA HACER POLIMORFICO BALA Y BOMBA PERO AUN NO ESTA TERMINADO!
	method disparar() {
		if( self.puedeDisparar()) {
			self.nuevoDisparo()
			self.puedeDisparar(false)
			
			const balita = new Bala(index = self.disparosHechos());
			balita.disparo(self.direccion());
			game.schedule(1000, { self.puedeDisparar(true) })			
		}
	}
	
			
	method inicializarTeclas() {
		keyboard.space().onPressDo({self.disparar()});
//		keyboard.b().onPressDo({bomba.disparar()});
		keyboard.up().onPressDo({ direccion = arriba });
		keyboard.down().onPressDo({ direccion = abajo });
		keyboard.left().onPressDo({ direccion = izquierda });
		keyboard.right().onPressDo({ direccion = derecha });
		keyboard.m().onPressDo({var murito = new Muro(tiempo = 6)})
		keyboard.n().onPressDo({var minita = new Mina(tiempo = 3)})
		keyboard.l().onPressDo({var loquito = new MuroLoco(tiempo = 3)})
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


