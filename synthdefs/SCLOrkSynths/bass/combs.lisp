;; A SynthDef by Josh Mitchell, 8/19.
;;
;; The core sound comes from brown noise being sent through two comb filters in series.
;; The first comb filter randomly fluctuates around the root frequency, creating an effect
;; halfway between vibrato and a flanger. The second filter is set to a harmonic of the
;; root frequency. After that, a tiny bit of runaway low end gets filtered out and the
;; sound is sent through an envelope filter for a vocal sort of sound.

(in-package :audio)
(named-readtables:in-readtable :sc)

(defsynth combs
    ((out 0) (pan 0) (amp 0.1) (freq 440.0) (gate 1) (att 0.01) (dec 0.1) (sus 0.7) (rel 0.5)
     (rate 6.0) (depth 0.2) (regen -3) (sweep 16) (rq 0.5) (harmonic 1.5))
  (let* (

         ;; Setting some values for the filters:
         (max (/ (+ 1 depth) freq))
         (min (/ 1 (* freq (+ 1 depth))))
         (vibrato (range (lf-noise1.ar rate) min max))

         ;; Amplitude and filter cutoff envelopes:
         (env (env-gen.kr (adsr att dec sus rel) :gate gate :act :free))
         (filterenv (* freq (+ 1 (* (env-gen.kr (perc att rel)) sweep))))

         ;; The core noise
         (snd1 (comb-l.ar (brown-noise.ar) max vibrato regen))
         (snd2 (comb-n.ar snd1 (/ harmonic freq) (/ harmonic freq) regen env))

         ;; More filters and output stuff:
         (snd3 (rhpf.ar snd2 (* freq 4) rq))
         (snd4 (rlpf.ar snd3 filterenv rq amp))
         (snd5 (limiter.ar snd4 amp)))
    (out.ar out (pan2.ar snd5 pan))))
