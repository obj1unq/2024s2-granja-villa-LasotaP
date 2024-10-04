import wollok.game.*
import cultivos.*
import posiciones.*
import granja.*

object hector {
	var property position = game.center()
	const property image = "player.png"

	method mover(direccion) {
		self.validarMover(direccion)
		position = direccion.siguiente(self.position())
	}

	method validarMover(direccion) {
		const siguiente = direccion.siguiente(self.position())
		granja.validarDentro(siguiente)
	}

	method validarSembrar(){
		if(granja.hayAlgoAca(self.position())){
			self.error("No puedo sembrar aca")
		}	
	}

	method sembrarMaiz() {
		self.validarSembrar()
		const cultivoActivo = new Maiz(position = position)
		game.addVisual(cultivoActivo)
		granja.plantaciones().add(cultivoActivo)
	}
	method sembrarTrigo() {
		self.validarSembrar()
		const cultivoActivo = new Trigo(position = position)
		game.addVisual(cultivoActivo)
		granja.plantaciones().add(cultivoActivo)		
	}
	method sembrarTomaco() {
		self.validarSembrar()
		const cultivoActivo = new Tomaco(position = position)
		game.addVisual(cultivoActivo)
		granja.plantaciones().add(cultivoActivo)
	}

	method validarRegar(){
		if (not granja.hayAlgoAca(self.position())) {
			self.error("No puedo regar aca!")
		}
	}

	method regarCultivo(){
		self.validarRegar()
		granja.cultivoEn(self.position()).regar()
	}

	method cosecharCultivo() {
		self.validarCosechar()
		granja.cultivoEn(self.position()).cosechar()
	}

	method validarCosechar() {
	  	if (not granja.hayAlgoAca(self.position())) {
			self.error("No hay nada para cosechar!")
		} else if ( not granja.cultivoEn(self.position()).listaParaCosechar()){
			self.error("Este cultivo no esta listo para cosechar!")
		}
	}
}