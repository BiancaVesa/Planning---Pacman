( define (domain FirstAid )
	
	(:types PERSON BODYPART DEGREE WOUND)
	
	(:predicates (dead ?p - PERSON)
		     (adult ?p - PERSON)
		     (child ?p - PERSON)
		     (infant ?p - PERSON)
		     (conscious ?p - PERSON)
     		     (encircle_abdomen ?p - PERSON)
		     (breathing ?p - PERSON)
		     (obese ?p - PERSON)
		     (pregnant ?p - PERSON)
		     (free_airway ?p - PERSON)
		     (complete_obstruction ?p - PERSON)
		     (see_foreign_body ?p - PERSON)
		     (infected ?p - PERSON ?w - WOUND)
		     (dress_wound ?p - PERSON ?w - WOUND)
		     (treat_wounds ?p - PERSON)
		     (tetanus ?p - PERSON)
		     (bleeding ?p - PERSON ?w - WOUND)
		     (hasWound ?p - PERSON ?w - WOUND)
     		     (pressure ?p - PERSON ?w - WOUND)		     
     		     (antiseptic ?p - PERSON ?w - WOUND)
		     (hasBodyP ?p - PERSON ?b - BODYPART)
		     (first_deg_burn ?p - PERSON ?b - BODYPART)
		     (second_deg_burn ?p - PERSON ?b - BODYPART)
		     (third_deg_burn ?p - PERSON ?b - BODYPART)
		     (treat_burns ?p - PERSON ?d - DEGREE)
		     (redness ?p - PERSON ?b - BODYPART)
		     (inflamation ?p - PERSON ?b - BODYPART)
		     (pain ?p - PERSON ?b - BODYPART)
		     (blistering ?p - PERSON ?b - BODYPART)
		     (swollen ?p - PERSON ?b - BODYPART)
		     (first_degree_burn ?p - PERSON ?b - BODYPART)
		     (ems_wounds ?p - PERSON) ;; emergency medical services
		     (ems_burns ?p - PERSON)
		     (ems_airwayObs ?p - PERSON)
	)
	
	;; check the obstruction of the person's airway	
	(:action sense_complete_obstruction
	 	:parameters (?p - PERSON)
	 	:observe (complete_obstruction ?p)
	)


	;; check the visibilty of the foreign body in person's airway
	(:action sense_foreign_body
	 	:parameters (?p - PERSON)
	 	:observe (see_foreign_body ?p)
	)
	
	
	;; check if the person is conscious
	(:action sense_consciousness
	 	:parameters (?p -PERSON)
	 	:observe (conscious ?p)
	)
	
	
	;; check if the person can breathing
	(:action sense_breathing
	 	:parameters (?p -PERSON)
	 	:observe (breathing ?p)
	)
	
	
	;; check if able to encircle the person's abdomen
	(:action sense_encircle_abdomen
	 	:parameters (?p -PERSON)
	 	:observe (encircle_abdomen ?p)
	)
	
	
	;; check if person's body parts have redness
	(:action sense_redness
	 	:parameters (?p - PERSON ?b - BODYPART)
	 	:observe (redness ?p ?b)
	)
	
	
	;; check if person's body parts have inflamation
	(:action sense_inflamation
	 	:parameters (?p - PERSON ?b - BODYPART)
	 	:observe (inflamation ?p ?b)
	)
	
	
	;; check if person's body parts have blistering
	(:action sense_blistering
	 	:parameters (?p - PERSON ?b - BODYPART)
	 	:observe (blistering ?p ?b)
	)
	
	
	;; check if person's body parts are painful
	(:action sense_pain
	 	:parameters (?p - PERSON ?b - BODYPART)
	 	:observe (pain ?p ?b)
	)
	
	
	;; check if person's wound is infected
	(:action sense_infection
	 	:parameters (?p - PERSON)
	 	:observe (infected ?p)
	)
	
	
	;; check if person's wound is bleeding
	(:action sense_bleeding
	 	:parameters (?p - PERSON)
	 	:observe (bleeding ?p)
	)
	
	
	;; check if the person has immunization to tetanus	
	(:action sense_tetanus
	 	:parameters (?p - PERSON)
	 	:observe (tetanus ?p)
	)
	
	;; if the person shows signs of mild airway obstruction, 
	;; encourage coughing
	(:action encourage_coughing
		:parameters (?p - PERSON)
		:precondition (and (breathing ?p)
				    (not (dead ?p))
				    (or (adult ?p) (child ?p))
				    (conscious ?p)
				    (not (complete_obstruction ?p))
			      )
		:effect (free_airway ?p)
	)
	
	
	;; if the person shows signs of complete airway obstruction, but can breathe weakly
	;; apply five back blows
	(:action five_back_blows
		:parameters (?p - PERSON)
		:precondition (and (breathing ?p)
				    (not (dead ?p))
				    (or (adult ?p) (child ?p) (infant ?p))
				    (conscious ?p)
				    (complete_obstruction ?p)
				)
		:effect (free_airway ?p)
	)

	
	;; manually remove the foreign object in the airway 
	;; only if it can be seen
	(:action finger_sweep
		:parameters (?p - PERSON)
	 	:precondition (and (breathing ?p)
	 			    (or (adult ?p) (child ?p) (infant ?p)) 				    
	 			    (see_foreign_body ?p)
				    (conscious ?p)
				    (not (dead ?p))
	 			)
	 	:effect (free_airway ?p)
	)
	
	
	;; if the person is not able to breathe,
	;; is not an infant, pregnant or obese and the person's abdomen cannot be encircled
	;; give five abdominal thrusts
	(:action abdominal_thrusts
		:parameters (?p - PERSON)
		:precondition (and (not (breathing ?p))
				    (or (not (obese ?p )) (and (encircle_abdomen ?p) (obese ?p)))
				    (not (pregnant ?p))
				    (not (infant ?p))
				    (conscious ?p)
				    (not (dead ?p))
				)
		:effect (free_airway ?p)
	)
	
	
	;; if the person is not able to breathe
	;; is an infant, pregnant or obese and the person's abdomen cannot be encircled
	;; give five chest thrusts
	(:action chest_thrusts
		:parameters (?p - PERSON)
		:precondition (and (not (breathing ?p))
				    (or (pregnant ?p) (and (not (encircle_abdomen ?p)) (obese ?p)) (infant ?p))
				    (conscious ?p)
				    (not (dead ?p))
				)
		:effect (free_airway ?p)
	)
		
		
	
	;; if at anytime, the person becomes or is found unconsious or in cardiac arrest
	;; begin cpr and call EMS
	(:action begin_cpr
		:parameters (?p - PERSON)
		:precondition (and  (not (dead ?p))
				     (or (adult ?p) (child ?p) (infant ?p))
				     (not (conscious ?p))
				)
		:effect (ems_airwayObs ?p)
	)
	
	
	;; check person's bodypart for first degree burn
	(:action check_first_degree_burn
		:parameters(?p - PERSON ?b - BODYPART)
		:precondition (and 
				    (not (dead ?p))
				    (redness ?p ?b)
				    (swollen ?p ?b)
				    (pain ?p ?b)
				    (hasBodyP ?p ?b)
			      )
		:effect (and  (first_degree_burn ?p ?b)
			      (when (and (not (ems_burns ?p)) 
					 (redness ?p palm)
				         (swollen ?p palm)
				         (pain ?p palm)
				     )
				     (ems_burns ?p)
			      )
			      (when (and (not (ems_burns ?p))
			                 (redness ?p face)
				         (swollen ?p face)
				         (pain ?p face)
				     )
				     (ems_burns ?p)
			      )
			      (when (and (not (ems_burns ?p))
			                 (redness ?p back_knee)
				         (swollen ?p back_knee)
				         (pain ?p back_knee)
				     )
				     (ems_burns ?p)
			      )
			 
			 )
	)

	
	;; treat person for first degree burn
	(:action clean_and_treat_first_degree_burn
		:parameters (?p - PERSON ?b - BODYPART)
		:precondition (and (not (ems_burns ?p))
				    (first_degree_burn ?p ?b)
				    (hasBodyP ?p ?b)
				)
		:effect (treat_burns ?p first_degree)
	)
	
	
	;; check person's bodypart for second degree burn
	(:action check_second_degree_burn
		:parameters(?p - PERSON ?b - BODYPART)
		:precondition (and (not (dead ?p))
		     		    (redness ?p ?b)
				    (inflamation ?p ?b)
				    (pain ?p ?b)
				    (blistering ?p ?b)
				    (hasBodyP ?p ?b)
				)
		:effect (ems_burns ?p)
	)
	
	
	;; check person's bodypart for third degree burn
	(:action check_third_degree_burn
		:parameters(?p - PERSON ?b - BODYPART)
		:precondition (and (not (dead ?p))
				    (redness ?p ?b)
				    (inflamation ?p ?b)
				    (not (pain ?p ?b))
				    (blistering ?p ?b)
				    (hasBodyP ?p ?b)
				)
		:effect (ems_burns ?p)
	)
	
	
	
	;; apply bandage if wound is not infected 
	;; or is not a puncture and the person doesn't have immunization to tetanus	
	(:action bandage
		:parameters(?p - PERSON ?w - WOUND)
		:precondition (and (hasWound ?p ?w)
				    (dress_wound ?p ?w)
				    (not (dead ?p))
			      )
		:effect(and (when (infected ?p ?w) (ems_wounds ?p))
			    (when (and (hasWound ?p puncture) (not (tetanus ?p))) (ems_wounds ?p))
			    (when (and (not (infected ?p ?w)) (or (not (hasWound ?p puncture)) (and (hasWound ?p puncture) (tetanus ?p))))  (treat_wounds ?p))
		
		       )
	)
	
	
	;; apply pressure on bleeding wound
	(:action apply_pressure
		:parameters (?p - PERSON ?w - WOUND)
		:precondition (pressure ?p ?w)
		:effect (dress_wound ?p ?w)
	)
	
	
	;; apply antiseptic solution on puncture wound
	(:action apply_antiseptic_solution
		:parameters (?p - PERSON ?w - WOUND)
		:precondition (antiseptic ?p ?w)
		:effect (dress_wound ?p ?w)
	)
	
	
	;; check and clean person's wound
	(:action check_and_clean_wound
		:parameters (?p -PERSON ?w - WOUND)
		:precondition (and (hasWound ?p ?w)
				    (not (dead ?p))
			       )
		:effect (and (when (bleeding ?p ?w) (pressure ?p ?w))
			      (when (hasWound ?p puncture) (antiseptic ?p ?w))
			      (when (not (bleeding ?p ?w)) (dress_wound ?p ?w))
			)
	)
	
	
	(:action call_ems_for_airway_obstruction
		:parameters (?p - PERSON)
		:precondition (ems_airwayObs ?p)
		:effect (and (free_airway ?p)
			     (not (dead ?p))
			 )
	)
	
	(:action call_ems_for_burns
		:parameters (?p - PERSON)
		:precondition (ems_burns ?p)
		:effect (and (treat_burns ?p first_degree)
   	  		     (treat_burns ?p second_degree)
   	  		     (treat_burns ?p third_degree)
   	  		     (not (dead ?p))
			 )
	)

	
	(:action call_ems_for_wounds
		:parameters (?p - PERSON)
		:precondition (ems_wounds ?p)
		:effect (and (treat_wounds ?p)
	   		      (not (dead ?p))
			 )
	)
)
