import socios.*

class Viaje {

	var property idioma = []
	var property dias = 0
	var property implicaEsfuerzo = false
	var property sirveParaBroncearse = false

	method agregarIdioma(cual) {
		idioma.add(cual)
	}

	method quitarIdioma(cual) {
		idioma.remove(cual)
	}

	method esInteresante() {
		return idioma.size() > 1
	}

	method esUnaActividadRecomendada(socio) {
		return socio.leAtrae(self) and self.esInteresante() and not socio.realizeActividad(self)
	}

}

class ViajeDePlaya inherits Viaje {

	var property largo = 0

	override method dias() {
		return largo / 500
	}

	override method implicaEsfuerzo() {
		return largo > 1200
	}

	override method sirveParaBroncearse() {
		return true
	}

}

class ExcursionACiudad inherits Viaje {

	var property atracciones = 0

	override method dias() {
		return atracciones / 2
	}

	override method implicaEsfuerzo() {
		return atracciones.between(5, 8)
	}

	override method sirveParaBroncearse() {
		return false
	}

	override method esInteresante() {
		return super() or atracciones == 5
	}

}

class ExcursionACiudadTropical inherits ExcursionACiudad {

	override method dias() {
		return super() + 1
	}

	override method sirveParaBroncearse() {
		return true
	}

}

class SalidaDeTrekking inherits Viaje {

	var property kilometros = 0
	var property diasDeSol = 0

	override method dias() {
		return kilometros / 50
	}

	override method implicaEsfuerzo() {
		return kilometros > 80
	}

	method seRecorrenMasDe120() {
		return kilometros > 120
	}

	method hayMasDe200DiasDeSol() {
		return diasDeSol > 200
	}

	method hayEntre100y200DiasDeSol() {
		return diasDeSol.between(100, 200)
	}

	override method sirveParaBroncearse() {
		return self.hayMasDe200DiasDeSol() or self.hayEntre100y200DiasDeSol() and self.seRecorrenMasDe120()
	}

	override method esInteresante() {
		return super () and diasDeSol > 140
	}

}

class ClasesDeGimnasia inherits Viaje {

	override method idioma() = [ "español" ]

	override method dias() {
		return 1
	}

	override method implicaEsfuerzo() {
		return true
	}

	override method sirveParaBroncearse() {
		return false
	}

	override method esUnaActividadRecomendada(socio) {
		return socio.edad().between(20, 30)
	}

}

class TallerLiterario inherits Viaje { // entiendo que deberian ser actividades

	var property libros = []

	method idiomasUsados() {
		return libros.filter({ libro => libro.idioma() })
	}

	method cantidadDeLibros() {
		return libros.size()
	}

	override method dias() {
		return self.cantidadDeLibros() + 1
	}

	method hayUnLibroDeMasDe500Pag() {
		return libros.any({ libro => libro.paginas() > 500 })
	}

	method todosDelMismoAutor() {
		return libros.all({ libro => libro.autor() == libro.autor() })
	}

	method hayMasDeUnLibro() {
		return self.cantidadDeLibros() > 1
	}

	override method implicaEsfuerzo() {
		return self.hayUnLibroDeMasDe500Pag() or self.todosDelMismoAutor() and self.hayMasDeUnLibro()
	}

	override method sirveParaBroncearse() {
		return false
	}

	override method esUnaActividadRecomendada(socio) {
		return socio.cantidadDeIdiomasQueHabla() > 1
	}

}

