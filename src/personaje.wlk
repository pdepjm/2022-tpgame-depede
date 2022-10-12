import bala.*

object personaje{ 
	var property position = game.center()
	method image() = "personaje.jpg"

	method disparar() {
		const posicionInicio = self.position();
		const balita = new Bala();
		balita.disparo();
	}
}
