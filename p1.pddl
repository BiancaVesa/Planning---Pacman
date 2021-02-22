(define (problem ForeignBodyAirwayObstruction)
(:domain FirstAid)
(:objects Robert Emily William - PERSON
	  first_degree second_degree third_degree - DEGREE
  	  leg palm face back_knee - BODYPART
  	  puncture - WOUND
)

(:init 

    (infant William)
    (conscious William)
    (breathing William)
    (see_foreign_body William)
    (complete_obstruction William)
    
    (adult Emily)
    (conscious Emily)
    (pregnant Emily)
    (breathing Emily)
    (complete_obstruction Emily)

    (adult Robert)
    (unknown (conscious Robert))
    (unknown (complete_obstruction Robert))
    (obese Robert)
    (unknown (encircle_abdomen Robert))	
    (unknown (breathing Robert))
    (unknown (see_foreign_body Robert))
    
    
)

(:goal (and (not (dead Robert))
	    (free_airway Robert)
	    
	    (not (dead Emily))
	    (free_airway Emily)
	    
	    (not (dead William))
	    (free_airway William)
        )
 	
)

)
