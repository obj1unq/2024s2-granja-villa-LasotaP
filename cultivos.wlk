import granja.*
import wollok.game.*
import hector.*

class Maiz {
	var property position
	var property image = "corn_baby.png"
	method regar() {
		self.image("corn_adult.png")
		self.image()
	}
	method listaParaCosechar() {
		return self.image() == "corn_adult.png"
	}
	method costo() = 150
}
class Trigo {
	var property position
	var etapaEvolucion = 0
	var property image = "wheat_"+etapaEvolucion+".png"
	
	method regar() {
	   if (etapaEvolucion < 3){
			etapaEvolucion += 1
			image = "wheat_" + (etapaEvolucion) + ".png"
	   } else {
			etapaEvolucion = 0
			image = "wheat_0.png"
	   }
	}
	method listaParaCosechar() {
		return etapaEvolucion > 1
	}
	method costo() = (etapaEvolucion-1)*100
}

class Tomaco {
	var property position
	method image() = "tomaco.png"
	method regar() {
		const nuevaPos = game.at(self.position().x(),self.position().y() + 1)
		if (not granja.hayAlgoAca(nuevaPos) and granja.estaDentro(nuevaPos)){
			self.position(nuevaPos)
		} else if (not granja.hayAlgoAca(game.at(self.position().x(),0))){
			self.position(game.at(self.position().x(),0))
		}
	}
	method listaParaCosechar() {
		return true
	}
	method costo() = 80
}
