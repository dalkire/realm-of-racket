#lang racket

(require 2htdp/universe
         2htdp/image)

(define WIDTH 100)
(define HEIGHT 200)

;; (define X-CENTER (quotient WIDTH 2))
;; (define Y-CENTER (quotient HEIGHT 2))

;; (define SQR-COLOR "red")
;; (define SQR-SIZE 10)

(define IMAGE-of-UFO (bitmap/file "ufo.png"))

(define (add-3-to-state current-state)
  (+ current-state 3))

(define (draw-a-ufo-onto-an-empty-scene current-state)
  (place-image IMAGE-of-UFO (/ WIDTH 2) current-state
               (empty-scene WIDTH HEIGHT)))

(define (state-is-100 current-state)
  (>= current-state 100))

(big-bang 0
          (on-tick add-3-to-state)
          (to-draw draw-a-ufo-onto-an-empty-scene)
          (stop-when state-is-100))

;; (define (draw-square img x y)
;;   (place-image (square SQR-SIZE "solid" SQR-COLOR)
;;                x y
;;                img))

;; (struct posn (x y))
;; (struct rectangle (width height))
;; (define (inside-of-rectangle r p)
;;   (define x (posn-x p))
;;   (define y (posn-y p))
;;   (define width (rectangle-width r))
;;   (define height (rectangle-height r))
;;   (and (<= 0 x) (< x width) (<= 0 y) (< y height)))

;; (define (random-stars n)
;;   (cond
;;     [(zero? n) '()]
;;     [else (define location (random-location 200 300))
;;           (if (inside-moon? location)
;;               (random-stars n)
;;               (cons location (random-stars (sub1 n))))]))

;; (unless (> HEIGHT 0)
;;   (error 'guess-my-number "HEIGHT may not be negative"))
