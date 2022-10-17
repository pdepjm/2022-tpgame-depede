import wollok.game.*


object arriba {
	method mover(n,obj) {
//		obj.up(n)
		return game.at(obj.position().x(),obj.up(n))
	}
	method prefijo() {
		return "ar"
	}
}

object abajo {
	method mover(n,obj) {
//		obj.down(n)
		return game.at(obj.position().x(),obj.down(n))
	}
	method prefijo() {
		return "ab"
	}
}

object derecha {
	var property image = "personaje-d.jpg"
	method mover(n,obj) {
//		obj.right(n)
		return game.at(obj.right(n),obj.position().y())
	}
	method prefijo() {
		return "d"
	}
}


object izquierda {
	var property image = "personaje-l.jpg"
	method mover(n,obj) {
		return game.at(obj.left(n),obj.position().y())
	}
	method prefijo() {
		return "i"
	}
}