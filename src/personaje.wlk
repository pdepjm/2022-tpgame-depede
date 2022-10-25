// herencia: Personajes, niveles. Ir cambiando y evolucionando.
// vida con imagenes que cambien!! -> cero necesario, no le dan bola a eso.

import bala.*
import movimientos.*
import instrucciones.*
import wollok.game.*

object personaje { 
	var disparosHechos = 0
	var property position = game.center()
	var property vida = 100
	var direccion = derecha // la direccion es un objeto
	var puedeDisparar = true
	const danio = game.sound("perrito-danio.mp3")
	var property puntos = 0
	var property zombiesRestantes = 30
	
	
	method puedeUsarse(habilidad){ return habilidad.cantidadPuntosRequeridos() <= self.puntos() }

	method usar(habilidad) {
		if ( self.puedeUsarse(habilidad) ) 
		{ 	
			habilidad.accionarse()
			self.puntos( self.puntos() - habilidad.cantidadPuntosRequeridos())
		}
			
	}

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
			
	method esperaDeDisparo() {
		self.nuevoDisparo()
		self.puedeDisparar(false)
		game.schedule(1000, { self.puedeDisparar(true) })	
	}
	
	// DEJAR TODO ESTO ASIII!! ES PARA HACER POLIMORFICO BALA Y BOMBA PERO AUN NO ESTA TERMINADO!
	method disparar() {
		if( self.puedeDisparar()) {
			const balita = new Bala(index = self.disparosHechos(),sentido = self.direccion());
			self.usar(balita)
			self.esperaDeDisparo()			
		}
		
	}
	
			
	method inicializarTeclas() {
		keyboard.space().onPressDo({self.disparar()});
//		keyboard.b().onPressDo({bomba.disparar()});
		keyboard.up().onPressDo({ direccion = arriba });
		keyboard.down().onPressDo({ direccion = abajo });
		keyboard.left().onPressDo({ direccion = izquierda });
		keyboard.right().onPressDo({ direccion = derecha });
		keyboard.m().onPressDo( { self.usar(new Muro()) })
		//keyboard.n().onPressDo({var minita = new Mina(tiempo = 3)})
		//keyboard.l().onPressDo({var loquito = new MuroLoco(tiempo = 3)})
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
		game.schedule(1,{danio.play()})
	}
	
	method choqueConZombie(zombie) {
		self.danoRecibido(zombie.danioQueHago())
	}
}


