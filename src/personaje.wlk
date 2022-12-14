import bala.*
import movimientos.*
import instrucciones.*
import objects.*
import wollok.game.*

object personaje { 
	var disparosHechos = 0
	var property position = game.center()
	var vida = 100
	var direccion = derecha // la direccion es un objeto
	var puedeDisparar = true
	var puedeRestarVida = true
	const danioTrack = game.sound("perrito-danio.mp3")
	var property puntos = 0
	var indexSonido 

	method vida() = vida
	
	method puedeRestarVida() = puedeRestarVida
	
	method puedeUsarse(habilidad){ return habilidad.cantidadPuntosRequeridos() <= puntos }

	method usar(habilidad) {
		if ( self.puedeUsarse(habilidad) ) { 	
			habilidad.accionarse()
			self.agregarPuntos(0 - habilidad.cantidadPuntosRequeridos())
		}
	}

	method image() = "personaje/personaje-" + direccion.prefijo() + ".png"

	method direccion() = direccion
	
	method puedeDisparar() = puedeDisparar
	method puedeDisparar(valor) {
		puedeDisparar = valor
	}
	
	method nuevoDisparo() {
		disparosHechos++
	}
	
	method agregarPuntos(cantidad) {
		puntos += cantidad
	}
	
	method disparosHechos() = disparosHechos
			
	method esperaDeDisparo() {
		self.nuevoDisparo()
		self.puedeDisparar(false)
		game.schedule(1000, { self.puedeDisparar(true) })	
	}
	
	method disparar() {
		if( self.puedeDisparar()) {
			const balita = new Bala(index = self.disparosHechos(),sentido = self.direccion());
			self.usar(balita)
			self.esperaDeDisparo()			
		}
	}
	
			
	method inicializarTeclas() {
		keyboard.space().onPressDo({self.disparar()});
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
			if(vida <= 0) {
				sonido.danio(danioTrack)
				self.perdiste()
			}
			puedeRestarVida = false
			game.schedule(1000, { puedeRestarVida = true })
			indexSonido = new SonidosPersonaje()
			indexSonido.reproducir()
		}
	}
	
	method choqueConZombie(zombie) {
		self.danoRecibido(zombie.danioQueHago())
	}
	

}


