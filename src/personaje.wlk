import bala.*
import movimientos.*
import instrucciones.*
import wollok.game.*

object personaje { 
	var disparosHechos = 0
	var property position = game.center()
	var vida = 100 // TODO: revisar
	var direccion = derecha // la direccion es un objeto
	var puedeDisparar = true
	var puedeRestarVida = true
	const danioTrack = game.sound("perrito-danio.mp3")
	var property puntos = 0

	method vida() = vida
	
	method puedeRestarVida() = puedeRestarVida
	
	method puedeUsarse(habilidad){ return habilidad.cantidadPuntosRequeridos() <= puntos }

	method usar(habilidad) {
		if ( self.puedeUsarse(habilidad) ) { 	
			habilidad.accionarse()
			self.puntos( self.puntos() - habilidad.cantidadPuntosRequeridos())
			// TODO: metodo que cambie puntos para restar tanto como para sumar
			// manejarPuntos ej
		}
	}

	method image() = "personaje/personaje-" + direccion.prefijo() + ".png"

	method direccion() = direccion
	
	// TODO: cambiar a variable. No hace falta get y set.
	// rompe encapsulamiento. Es interno el uso.
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
		}
	}
	
	method choqueConZombie(zombie) {
		self.danoRecibido(zombie.danioQueHago())
	}
	

}


