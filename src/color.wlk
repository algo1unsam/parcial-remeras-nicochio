class ColorBasico {

	method valor(unCosto) = 0

}

class Color inherits ColorBasico {

	override method valor(unCosto) = unCosto * 10/100

}

