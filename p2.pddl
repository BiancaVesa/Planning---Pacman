(define (problem Burns)
(:domain FirstAid)
(:objects Oliver Jessica Joe Anna - PERSON
	  first_degree second_degree third_degree - DEGREE
  	  back arm leg palm face back_knee - BODYPART
  	  puncture - WOUND
)

(:init     
    (hasBodyP Jessica arm)
    (swollen Jessica arm)
    (redness Jessica arm)
    (pain Jessica arm)
    
    
    (hasBodyP Joe face)
    (swollen Joe face)
    (redness Joe face)
    (pain Joe face)
    
    (hasBodyP Oliver leg)
    (swollen Oliver leg)
    (redness Oliver leg)
    (pain Oliver leg)
    

    (hasBodyP Oliver arm)
    (redness Oliver arm)
    (inflamation Oliver arm)
    (pain  Oliver arm)
    (blistering Oliver arm)
    
    (hasBodyP Anna back)
    (redness Anna back)
    (inflamation Anna back)
    (unknown (pain Anna back))
    (blistering Anna back)
)

(:goal (and (not (dead Oliver))
	    (not (dead Joe))
	    (not (dead Jessica))
	    (not (dead Anna))
	      (treat_burns Joe first_degree)
	      
	      (treat_burns Jessica first_degree)
	      
	      (treat_burns Oliver first_degree)
      	      (treat_burns Oliver second_degree)
      	      
      	      (treat_burns Anna second_degree)
      	      (treat_burns Anna third_degree)
        )
 	
)

)
