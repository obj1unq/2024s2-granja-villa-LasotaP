import wollok.game.*
import cultivos.*
import posiciones.*
import granja.*

object hector {
	var property position = game.center()
	const property image = "player.png"
	const property listaCosechados = #{}
	var property monedas = 0

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
		granja.cosecharCulivoEn(self.position())
	}

	method validarCosechar() {
	  	if (not granja.hayAlgoAca(self.position())) {
			self.error("No hay nada para cosechar!")
		} else if ( not granja.cultivoEn(self.position()).listaParaCosechar()){
			self.error("Este cultivo no esta listo para cosechar!")
		}
	}

	method vender() {
		monedas = listaCosechados.sum({planta => planta.costo()})
		listaCosechados.clear()
	}


	method hablar() {
		game.say(self, "Tengo "+monedas+" monedas, y "+listaCosechados.size()+" plantas para vender")
	}
}