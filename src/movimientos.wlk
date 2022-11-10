import wollok.game.*


object arriba {
	method mover(n,obj) {
		obj.position(obj.position().up(n))
	}
	method prefijo() {
		return "w"
	}
}

object abajo {
	method mover(n,obj) {
		obj.position(obj.position().down(n))
	}
	method prefijo() {
		return "s"
	}
}

object derecha {
	method mover(n,obj) {
		obj.position(obj.position().right(n))
	}
	method prefijo() {
		return "d"
	}
}


object izquierda {
	method mover(n,obj) {
		obj.position(obj.position().left(n))
	}
	method prefijo() {
		return "a"
	}
}