(define (problem Wounds)
(:domain FirstAid)
(:objects Lily Jake Mia - PERSON
	  first_degree second_degree third_degree - DEGREE
  	  back arm leg palm face back_knee - BODYPART
  	  puncture cut - WOUND
)

(:init 

    (hasWound Lily cut)
    (tetanus Lily)
    (infected Lily cut)
    (unknown (bleeding Lily cut))
    
    (hasWound Mia cut)
    (tetanus Mia)
    (unknown (infected Mia cut))
    (unknown (bleeding Mia cut))
    
    (hasWound Jake puncture)
    (unknown (bleeding Jake puncture))
    (unknown (tetanus Jake))
    
)

(:goal (and (not (dead Lily))
	    (treat_wounds Lily)
	    
	    (not (dead Jake))
	    (treat_wounds Jake)
	    
	    (not (dead Mia))
	    (treat_wounds Mia)
        )
 	
)

)
