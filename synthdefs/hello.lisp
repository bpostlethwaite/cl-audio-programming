(defsynth saw-synth-hello ((note 60) (dur 4.0))
  (let* ((env (env-gen.kr (env [0 .2 0] [(* dur .2) (* dur .8)]) :act :free))
         (freq (midicps note))
    	 (sig (lpf.ar (saw.ar freq env) (* freq 2))))
    (out.ar 0 [sig sig])))

(defun make-melody-hello (time n &optional (offset 0))
  (when (> n 0)
    (at time (synth 'saw-synth-hello :note (+ offset (alexandria:random-elt '(62 65 69 72)))))
      (let ((next-time (+ time (alexandria:random-elt '(0 1 2 1.5)))))
        (callback next-time #'make-melody next-time (- n 1) offset))))

(defun hello ()
  (make-melody-hello (quant 4) 16))
