(funcall
  (funcall
    (function
      (lambda (x) (x 2)
        (function
          (lambda (z)
            (+ z 1)
          )
        )
      )
    )
  )
)
