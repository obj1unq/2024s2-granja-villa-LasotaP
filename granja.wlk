import hector.*
import wollok.game.*
import cultivos.*

object granja {
    var property plantaciones = #{}

    method validarDentro(position) {
		if (not self.estaDentro(position)) {
			hector.error("No puedo moverme fuera del tablero")
		}
	}

	method estaDentro(position) {
		return position.x().between(0, game.width() - 1) and position.y().between(0, game.height() - 1)
	}

    method hayAlgoAca(posicion) {
        return self.plantaciones().any({a => a.position() == posicion})
    }

    method cultivoEn(posicion) {
        return if(self.hayAlgoAca(posicion)) {self.plantaciones().find({a => a.position() == posicion})}
    }
}