object exceptionNoExisteSucursal inherits Exception {

}

class Empresa {

	var property sucursales = []

	method agregarPedido(pedido, sucursal) {
		if (sucursales.contains(sucursal)) {
			sucursal.agregarPedido(pedido)
		} else {
			throw exceptionNoExisteSucursal
		}
	}

	method facturacionDeLaEmpresa() {
	return	sucursales.sum{ sucursal => sucursal.facturacionDeLaSucursal()}
	}

	method facturacionDeLaSucursal(sucursal) {
		if (sucursales.contains(sucursal)) {
			return sucursal.facturacionDeLaSucursal()
		} else {
			throw exceptionNoExisteSucursal
		}
	}

	method sucursalQueMasFacturo() {
		sucursales.max{ sucursal => sucursal.facturacionDeLaEmpresa()}
	}

	method cantidadDePedidosDelColor(color) {
		return sucursales.sum{ sucursal => sucursal.pedidos().filter{ pedido => pedido.remera().colorBase() == color}.size() }
	}

	method pedidoMasCaro() {
		var sucursalConMayorPedido = sucursales.max{ sucursal => sucursal.pedidoMasCaro().valor() }
		return sucursalConMayorPedido.pedidoMasCaro()
	}

	method sucursalesQueVendieronTodosLosTalles() {
		return sucursales.filter{ sucursal => sucursal.todosLosTallesVendidos() }
	}

}

class Pedido {

	var property remera = null
	var property cantidad = 0
	var property descuento = false

	method valorBase() {
		return (remera.costo() * cantidad)
	} 

	method valorDescuento() {
		if (descuento) {
			return remera.descuento() * cantidad
		} else {
			return 0
		}
	}

	method valor() {
		return self.valorBase() - self.valorDescuento()
	}

}

class Sucursal {

	var property pedidos = []
	var tallesPedidos = []
	var property cantMinimaParaDescuento = 100

	method hayDescuento(cantidad) {
		return cantidad >= cantMinimaParaDescuento
	}

	method agregarPedido(pedido) {
		if (self.hayDescuento(pedido.cantidad())) {
			pedido.descuento(true)
		}
		tallesPedidos.add(pedido.remera().talle())
		pedidos.add(pedido)
	}

	method facturacionDeLaSucursal() {
		return pedidos.sum{ pedido => pedido.valor() }
	}

// los talles son 16 
	method todosLosTallesVendidos() {
		return tallesPedidos.asSet().size() == 16
	}

	method pedidoMasCaro() {
		return pedidos.max{ pedido => pedido.valor() }
	}

}

