(define (domain agencia-viajes)
  (:requirements :strips :typing :fluents :negative-preconditions)

  (:types
    ciudad hotel - object
  )

  (:predicates
    (en ?c - ciudad)
    (visitada ?c - ciudad)
    (hotel-en ?h - hotel ?c - ciudad)
    (alojado ?h - hotel)
    (viaje-iniciado)
    (vuelo ?c1 ?c2 - ciudad)
  )

  (:functions
    (total-precio)
    (total-interes)
    (total-dias)
    (num-ciudades-visitadas)
    (precio-vuelo ?c1 ?c2 - ciudad)
    (precio-hotel ?h - hotel)
    (interes-ciudad ?c - ciudad)
    (min-dias-ciudad ?c - ciudad)
    (max-dias-ciudad ?c - ciudad)
    (dias-estancia-actual)
  )

  ;; Iniciar viaje: El planificador elige dónde empezar
  (:action iniciar-viaje
    :parameters (?c - ciudad ?h - hotel)
    :precondition (and (not (viaje-iniciado)) (hotel-en ?h ?c))
    :effect (and
        (viaje-iniciado)
        (en ?c)
        (visitada ?c)
        (alojado ?h)
        (assign (total-precio) (precio-hotel ?h))
        (assign (total-interes) (interes-ciudad ?c))
        (assign (total-dias) 1)
        (assign (dias-estancia-actual) 1)
        (assign (num-ciudades-visitadas) 1)
    )
  )

  ;; Añadir días: Solo si no superamos el máximo de la ciudad
  (:action extender-estancia
    :parameters (?c - ciudad ?h - hotel)
    :precondition (and 
        (en ?c) 
        (alojado ?h)
        (< (dias-estancia-actual) (max-dias-ciudad ?c))
    )
    :effect (and
        (increase (total-dias) 1)
        (increase (dias-estancia-actual) 1)
        (increase (total-precio) (precio-hotel ?h))
    )
  )

  ;; Volar: Solo si hemos cumplido la estancia mínima (MIN-DIAS)
  (:action volar-y-alojarse
    :parameters (?orig - ciudad ?dest - ciudad ?h-new - hotel)
    :precondition (and
        (en ?orig)
        (vuelo ?orig ?dest)
        (not (visitada ?dest))
        (hotel-en ?h-new ?dest)
        ;; RESTRICCIÓN CLAVE: Verificar estancia mínima antes de salir
        (>= (dias-estancia-actual) (min-dias-ciudad ?orig))
    )
    :effect (and
        (not (en ?orig))
        (en ?dest)
        (visitada ?dest)
        (alojado ?h-new)
        (increase (total-precio) (+ (precio-vuelo ?orig ?dest) (precio-hotel ?h-new)))
        (increase (total-interes) (interes-ciudad ?dest))
        (increase (total-dias) 1)
        (assign (dias-estancia-actual) 1)
        (increase (num-ciudades-visitadas) 1)
    )
  )
)