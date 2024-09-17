; Model "Sample Models/Mathematics/Vector Fields.nlogo"

breed [ particles particle ]  ;; the things that are affected by the field
breed [ vectors vector ]    ;; the vectors that affect the particles

globals
[
  max-modulus  ;; the maximum modulus of all the vectors
  clicked?     ;; true if we have clicked the mouse button but have not yet placed a particle
  step-size    ;; the amount a particle moves forward
]

vectors-own
[
  modulus  ;; the length of the vector
]

;; set up the field, and create vectors
to setup
  clear-all
  set clicked? false

  ;; have particles move forward a small amount each time so that we
  ;; don't spiral too much but also so that the model doesn't run too slowly
  set step-size 0.0001

  ;; create vectors at regular intervals to see the effect of the force
  ;; at a particular place.
  ask patches
  [
    if (pxcor mod 13 = 0) and (pycor mod 13 = 0)
    [
      sprout-vectors 1
      [ setup-vector ]
    ]
  ]
  ;; draw vector field
  set max-modulus (max [modulus] of vectors)
  ask vectors [ show-vector ]
  reset-ticks
end

;; make the turtle become a vector and initialize the vector's variables
to setup-vector  ;; turtle procedure
  set color green
  pen-down
  if (force-x != 0) or (force-y != 0)
    [ set heading atan force-x force-y ]
  set modulus distancexy 0 0
end

;; particles update their orientation according to the vector-field force
;; operating on the patch where they are at
to go
  let stop? false
  ask particles
  [
    ;; calculate the heading based on the force where this turtle is
    if force-x != 0 or force-y != 0
      [ set heading (atan force-x force-y) ]

    forward step-size * (distancexy 0 0)
  ]
  ;; 100 is an arbitrary factor used to produce a reasonable
  ;; frequency of view updates
  tick-advance 100 * step-size
  ;; if one of the particles was going to wrap around the world, stop.
  if stop?
  [ stop ]
end

;; report true if we will wrap around if we move forward by step-size
to-report going-to-wrap?  ;; turtle procedure
  let next-patch patch-ahead step-size
  report next-patch = nobody
end

;; place test particles
to place-particles
  if mouse-down?
  [ set clicked? true ]
  if (not mouse-down?) and clicked?
  [ place-particle mouse-xcor mouse-ycor
    display ]
end

;; create a particle at (x,y)
to place-particle [x y]
  create-particles 1
  [
    setxy x y
    set size 10
    set heading 0
    set color red
    pen-down  ;; put the pen down so that we can see where it has traveled
    if force-x != 0 or force-y != 0
      [ set heading (atan force-x force-y) ]
  ]
  set clicked? false
end

;; calculate the horizontal force where the turtle is located
to-report force-x  ;; turtle procedure
  report ycor
end

;; calculate the vertical force where the turtle is located
to-report force-y  ;; turtle procedure
  report (- xcor)
end

;; draw the vector using a turtle to display strength and direction of field
to show-vector  ;; turtle procedure
  set modulus (10 * modulus / max-modulus)
  forward modulus
  set color yellow
end

; Copyright 1998 Uri Wilensky.
; This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 License. To view a copy of this license, visit https://creativecommons.org/licenses/by-nc-sa/3.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.
;
; Commercial licenses are also available. To inquire about commercial licenses, please contact Uri Wilensky at uri@northwestern.edu.
;
; This model was created as part of the project: CONNECTED MATHEMATICS: MAKING SENSE OF COMPLEX PHENOMENA THROUGH BUILDING OBJECT-BASED PARALLEL MODELS (OBPML). The project gratefully acknowledges the support of the National Science Foundation (Applications of Advanced Technologies Program) -- grant numbers RED #9552950 and REC #9632612.
;
; This model was converted to NetLogo as part of the projects: PARTICIPATORY SIMULATIONS: NETWORK-BASED DESIGN FOR SYSTEMS LEARNING IN CLASSROOMS and/or INTEGRATED SIMULATION AND MODELING ENVIRONMENT. The project gratefully acknowledges the support of the National Science Foundation (REPP & ROLE programs) -- grant numbers REC #9814682 and REC-0126227. Converted from StarLogoT to NetLogo, 2002.
