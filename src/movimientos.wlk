import wollok.game.*


// Creo que va algo asi como: game.at(pepe.left(distancia))
object arriba {
	method mover(n,obj) {
		obj.up(n)
	}
}

// Creo que va algo asi como: game.at(pepe.left(distancia))
object abajo {
	method mover(n,obj) {
		obj.down(n)
	}
}

// Creo que va algo asi como: game.at(pepe.left(distancia))
object derecha {
	var property image = "personaje-d.jpg"
	method mover(n,obj) {
		obj.right(n)
	}
}

// Creo que va algo asi como: game.at(pepe.left(distancia))
object izquierda {
	var property image = "personaje-l.jpg"
	method mover(n,obj) {
		obj.left(n)
	}
}