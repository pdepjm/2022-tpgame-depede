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
	var puedeRestarVida = true
	const danioTrack = game.sound("perrito-danio.mp3")
	var property puntos = 0
	var property zombiesRestantes = 30
	
	method puedeRestarVida() = puedeRestarVida
	
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
		keyboard.m().onPressDo({self.usar(new Muro())})
		keyboard.n().onPressDo({self.usar(new Mina())})
		keyboard.l().onPressDo({self.usar(new MuroLoco())})
	}
	
	method perdiste() {
		game.removeVisual(self)
		instrucciones.gameOver()
	}
	
	method danoRecibido(cuantoDanio) {
		if(puedeRestarVida) {
			vida = 0.max(vida - cuantoDanio)
			sonido.danio(danioTrack)
			if(vida <= 0) {
				self.perdiste()
			}
			puedeRestarVida = false
			game.schedule(1000, { puedeRestarVida = true })			
		}
	}
	
	method choqueConZombie(zombie) {
		self.danoRecibido(zombie.danioQueHago())
	}
	
	method quedanZombiesPorMatar() {
		return self.zombiesRestantes() > 0
	}
}


