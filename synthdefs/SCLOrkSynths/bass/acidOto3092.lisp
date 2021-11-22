(in-package :audio)
(named-readtables:in-readtable :sc)

;; https://github.com/SCLOrkHub/SCLOrkSynths/blob/master/SynthDefs/bass/acidOto3091.scd
;; TODO - len 4 Curve arrays, see src
(defsynth acid-Oto309
     ;; width is [0, 1], filter-range is in octaves
    ((out 0) (gate 1) (freq 440) (amp 0.1) (pan 0) (att 0.001) (dec 0.5) (sus 0.1) (rel 0.5) (curve -4.0)
     (lag-time 0.12) (filter-range 6) (width 0.51) (rq 0.3))

  (let* ((freq (lag.kr freq lag-time))
         (amp-env (env-gen.kr (adsr att dec sus rel amp (list 0.0 curve curve)) :gate gate))
         (filter-env
           (env-gen.kr
            (adsr att (* dec 2) (/ sus 2) (* rel 2) (expt 2 filter-range) (list (* -1.0 curve) curve curve) 1.0)
            :gate gate :act :free))
         (op1 (range (lf-pulse.ar freq 0.0 width) -1.0 1.0))
         (op2 (rlpf.ar op1 (* freq filter-env) rq))
         (op3 (* op2 amp-env)))
    (out.ar out (pan2.ar op3 pan))))
