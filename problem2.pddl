(define (problem itinerario-largo)
  (:domain agencia-viajes)
  
  (:objects
    barcelona paris londres roma berlin - ciudad
    h-bcn h-par h-lon h-rom h-ber - hotel
  )

  (:init
    (= (total-precio) 0)
    (= (total-interes) 0)
    (= (total-dias) 0)
    (= (num-ciudades-visitadas) 0)
    (= (dias-estancia-actual) 0)

    ;; Interès de les ciutats (1 és el màxim interès)
    (= (interes-ciudad barcelona) 2)
    (= (interes-ciudad paris) 1)
    (= (interes-ciudad londres) 2)
    (= (interes-ciudad roma) 1)
    (= (interes-ciudad berlin) 1)

    ;; Días mínimos y máximos
    (= (min-dias-ciudad barcelona) 1) (= (max-dias-ciudad barcelona) 3)
    (= (min-dias-ciudad paris) 2)     (= (max-dias-ciudad paris) 4)
    (= (min-dias-ciudad londres) 2)   (= (max-dias-ciudad londres) 3)
    (= (min-dias-ciudad roma) 2)      (= (max-dias-ciudad roma) 3)
    (= (min-dias-ciudad berlin) 2)    (= (max-dias-ciudad berlin) 4)

    ;; Hoteles (Berlín és molt barat, Londres molt car)
    (hotel-en h-bcn barcelona) (= (precio-hotel h-bcn) 100)
    (hotel-en h-par paris)     (= (precio-hotel h-par) 120)
    (hotel-en h-lon londres)   (= (precio-hotel h-lon) 180)
    (hotel-en h-rom roma)      (= (precio-hotel h-rom) 90)
    (hotel-en h-ber berlin)    (= (precio-hotel h-ber) 60)

    ;; Conexiones (Grafo bidireccional)
    (vuelo barcelona paris) (= (precio-vuelo barcelona paris) 40)
    (vuelo paris barcelona) (= (precio-vuelo paris barcelona) 40)
    
    (vuelo paris londres)   (= (precio-vuelo paris londres) 80)
    (vuelo londres paris)   (= (precio-vuelo londres paris) 80)
    
    (vuelo londres berlin)  (= (precio-vuelo londres berlin) 60)
    (vuelo berlin londres)  (= (precio-vuelo berlin londres) 60)
    
    (vuelo berlin roma)     (= (precio-vuelo berlin roma) 50)
    (vuelo roma berlin)     (= (precio-vuelo roma berlin) 50)
    
    (vuelo barcelona roma)  (= (precio-vuelo barcelona roma) 150)
    (vuelo roma barcelona)  (= (precio-vuelo roma barcelona) 150)
  )

  (:goal
    (and
      (>= (num-ciudades-visitadas) 4) ;; Ara demanem 4 ciutats
      (>= (total-dias) 8)             ;; Més dies mínims
      (>= (total-precio) 400)         
      (<= (total-precio) 2000)
      (viaje-finalizado)
    )
  )

  ;; Extensión 4: Optimizar precio e interés
  (:metric minimize (+ (* 1 (total-precio)) (* 10 (total-interes))))
)