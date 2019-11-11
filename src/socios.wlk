import viajes.*

class Socio {

	var property actividades = []
	var property maximoDeActividades = 0
	var property edad = 0
	var property idiomasQueHabla = []

	method esAdoradorDelSol() {
		return actividades.all({ actividad => actividad.sirveParaBroncearse() })
	}

	method actividadesEsforzadas() {
		return actividades.filter({ actividad => actividad.implicaEsfuerzo() })
	}

	method cantidadDeActividades() {
		return actividades.size()
	}

	method topeDeActividades() {
		return self.cantidadDeActividades() >= maximoDeActividades
	}

	method registrarActividad(cual) {
		if (self.topeDeActividades()) {
			self.error("Capacidad completa de actividades")
		}
		actividades.add(cual)
	}

	method realizeActividad(cual) {
		return actividades.any({ c => c == cual })
	}

	method cantidadDeIdiomasQueHabla() {
		return idiomasQueHabla.size()
	}

}

class SocioTranquilo inherits Socio {

	method leAtrae(actividad) {
		return actividad.dias() >= 4
	}

}

class SocioCoherente inherits Socio {

	method leAtrae(actividad) {
		if (self.esAdoradorDelSol()) {
			return actividad.sirveParaBroncearse()
		} else {
			return actividad.implicaEsfuerzo()
		}
	}

}

class SocioRelajado inherits Socio {

	method idiomasDeLaActividad(actividad) {
		return actividad.idioma()
	}

	method idiomasQueHablo() {
		return idiomasQueHabla
	}

	method leAtrae(actividad) {
		return self.idiomasDeLaActividad(actividad).any({ c => c == self.idiomasQueHablo() })
	}

}

