(define (problem itinerario-verano)
  (:domain agencia-viajes)
  
  (:objects
    barcelona paris londres roma - ciudad
    h-bcn h-par h-lon h-rom - hotel
  )

  (:init
    (= (total-precio) 0)
    (= (total-interes) 0)
    (= (total-dias) 0)
    (= (num-ciudades-visitadas) 0)
    (= (dias-estancia-actual) 0)

    ;; Datos de ciudades e interés
    (= (interes-ciudad barcelona) 1)
    (= (interes-ciudad paris) 1)
    (= (interes-ciudad londres) 2)
    (= (interes-ciudad roma) 1)

    ;; Días mínimos y máximos (Extensión 1)
    (= (min-dias-ciudad barcelona) 2) (= (max-dias-ciudad barcelona) 4)
    (= (min-dias-ciudad paris) 2)     (= (max-dias-ciudad paris) 3)
    (= (min-dias-ciudad londres) 1)   (= (max-dias-ciudad londres) 2)
    (= (min-dias-ciudad roma) 2)      (= (max-dias-ciudad roma) 3)

    ;; Hoteles
    (hotel-en h-bcn barcelona) (= (precio-hotel h-bcn) 100)
    (hotel-en h-par paris)     (= (precio-hotel h-par) 150)
    (hotel-en h-lon londres)   (= (precio-hotel h-lon) 120)
    (hotel-en h-rom roma)      (= (precio-hotel h-rom) 90)

    ;; Conexiones
    (vuelo barcelona paris) (= (precio-vuelo barcelona paris) 50)
    (vuelo paris londres)   (= (precio-vuelo paris londres) 80)
    (vuelo londres roma)    (= (precio-vuelo londres roma) 70)
  )

  (:goal
    (and
      (>= (num-ciudades-visitadas) 3)
      (>= (total-dias) 6)
      (<= (total-precio) 1500)
    )
  )

  ;; Extensión 4: Optimizar precio e interés
  (:metric minimize (+ (* 0.1 (total-precio)) (* 10 (total-interes))))
)