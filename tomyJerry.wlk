object casa {
    var suciedad = 0
    var cuidadorActual = null
    var quilomberoActual = null

    method suciedad() = suciedad
    method cuidador() = cuidadorActual
    method quilombero() = quilomberoActual

    method ponerCuidador(cuidador) {
        cuidadorActual = cuidador
    }

    method meterQuilombero(quilombero) {
        quilomberoActual = quilombero
    }

    method agregarSuciedad(cantidad) {
        suciedad = suciedad + cantidad
    }

    method dejarLimpia() {
        suciedad = 0
    }

    method reiniciar() {
        suciedad = 0
        cuidadorActual = null
        quilomberoActual = null
    }

    method dia(cuidador) {
        self.ponerCuidador(cuidador)
        cuidador.limpiar(self)
        if (quilomberoActual != null && cuidador.puedeAtrapar(quilomberoActual)) {
            quilomberoActual = null
        }
    }

    method noche() {
        cuidadorActual.dormir()
        if (quilomberoActual != null) {
            quilomberoActual.hacerQuilombo(self)
            if (quilomberoActual.interrumpeSueno()) {
                cuidadorActual.interrumpirSueno()
            }
        }
    }
}

object tom {
    var energia = 0

    method energia() = energia
    method setEnergia(nuevaEnergia) {
        energia = nuevaEnergia
    }
    method velocidad() = 5 + energia / 10

    method limpiar(casa) {
        casa.agregarSuciedad(-100)
        energia = energia - 40
    }

    method puedeAtrapar(quilombero) = self.velocidad() > quilombero.velocidad()
    method dormir() {
        energia = energia + 50
    }
    method interrumpirSueno() {
        energia = energia - 20
    }
}

object jerry {
    var peso = 0

    method peso() = peso
    method setPeso(nuevoPeso) {
        peso = nuevoPeso
    }
    method velocidad() = 10 - peso

    method hacerQuilombo(casa) {
        casa.agregarSuciedad(110)
        peso = peso + 1
    }
    method interrumpeSueno() = false
}

object tuffy {
    method velocidad() = 10
    method hacerQuilombo(casa) {}
    method interrumpeSueno() = true
}

object robocat {
    method limpiar(casa) {
        casa.dejarLimpia()
    }
    method puedeAtrapar(quilombero) = true
    method dormir() {}
    method interrumpirSueno() {}
}

object pandilla {
    var miembros = []

    method crear(nuevosMiembros) {
        miembros = nuevosMiembros
        return self
    }

    method velocidad() = miembros.map { miembro => miembro.velocidad() }.min() / 2

    method hacerQuilombo(casa) {
        miembros.forEach { miembro => miembro.hacerQuilombo(casa) }
    }

    method interrumpeSueno() = miembros.size() > 3
}
