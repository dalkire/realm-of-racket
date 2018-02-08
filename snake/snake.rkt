#lang racket

(require 2htdp/universe
         2htdp/image)

(define WIDTH 500)
(define HEIGHT 200)
(define TEXT-SIZE 18)
(define SIZE 48)
(define TEXT-X 20)
(define TEXT-UPPER-Y 20)
(define TEXT-LOWER-Y 180)

(struct interval (lower upper) #:transparent)

(define HELP-TEXT
  (text "up-arrow for larger numbers, down-arrow for smaller ones"
        TEXT-SIZE
        "blue"))
(define HELP-TEXT2
  (text "Press = when your number is guessed; q to quit."
        TEXT-SIZE
        "blue"))
(define COLOR "red")

(define MT-SC
  (place-image/align
   HELP-TEXT TEXT-X TEXT-UPPER-Y "left" "top"
   (place-image/align
    HELP-TEXT2 TEXT-X TEXT-LOWER-Y "left" "bottom"
    (empty-scene WIDTH HEIGHT))))

(define (start lower upper)
  (big-bang (interval lower upper)
            (on-key deal-with-guess)
            (to-draw render)
            (stop-when single? render-last-scene)))

(define (deal-with-guess w key)
  (cond [(key=? key "up") (bigger w)]
        [(key=? key "down") (smaller w)]
        [(key=? key "q") (stop-with w)]
        [(key=? key "=") (stop-with w)]
        [else w]))

(define (smaller w)
  (interval (interval-lower w)
            (max (interval-lower w) (sub1 (guess w)))))

(define (bigger w)
  (interval (min (interval-upper w) (add1 (guess w)))
            (interval-upper w)))

(define (guess w)
  (quotient (+ (interval-lower w) (interval-upper w)) 2))

(define (render w)
  (overlay (text (number->string (guess w)) SIZE COLOR) MT-SC))

(define (render-last-scene w)
  (overlay (text "End" SIZE COLOR) MT-SC))

(define (single? w)
  (= (interval-lower w) (interval-upper w)))

;; (start 0 100)
