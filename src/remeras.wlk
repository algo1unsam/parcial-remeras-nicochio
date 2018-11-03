import marca.*

object exceptionNoExisteTalle inherits Exception {

}

class RemeraLisa {

	var property talle = 0
	var property colorBase = null

	method valorBaseTalle() {
		if (talle >= 32 && talle <= 40) {
			return 80
		} else if (talle >= 41 && talle <= 48) {
			return 100
		} else {
			throw exceptionNoExisteTalle
		}
	}

	method costoBaseColor() {
		return colorBase.valor(self.valorBaseTalle())
	}

	method costo() {
		return self.valorBaseTalle() + self.costoBaseColor()
	}

	method descuento() {
		return 10 / 100 * self.costo()
	}

}

class RemeraBordada inherits RemeraLisa {

	var property coloresBordados = []

	method valorBordado() {
		if (coloresBordados.size() <= 1) {
			return 20
		} else {
			return coloresBordados.size() * 10
		}
	}

	override method costo() {
		return super() + self.valorBordado()
	}

	override method descuento() = 0

}

class RemeraSublimada inherits RemeraLisa {

	var property alto = 0
	var property ancho = 0
	var property marcaDeLaEstampa = null

	method valorSublimado() {
		return (alto * ancho * 0.5) + marcaDeLaEstampa.derechosDeAutor()
	}

	override method costo() {
		return super () + self.valorSublimado()
	}

	override method descuento() {
		if (marcaDeLaEstampa.hayConvenio()) {
			return (20 / 100 * self.costo())
		} else {
			return super()
		}
	}

}

