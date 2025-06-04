;; Demand Response Contract
;; Handles energy demand response programs

(define-constant ERR_NOT_AUTHORIZED (err u300))
(define-constant ERR_PROGRAM_NOT_FOUND (err u301))
(define-constant ERR_ALREADY_ENROLLED (err u302))

;; Data structures
(define-map demand-programs
  { program-id: uint }
  {
    name: (string-ascii 50),
    incentive-rate: uint,
    max-participants: uint,
    current-participants: uint,
    active: bool
  }
)

(define-map participant-enrollments
  { participant: principal, program-id: uint }
  {
    enrolled-at: uint,
    total-savings: uint,
    participation-count: uint
  }
)

(define-data-var next-program-id uint u1)

;; Public functions
(define-public (create-demand-program (name (string-ascii 50)) (incentive-rate uint) (max-participants uint))
  (let ((program-id (var-get next-program-id)))
    (map-set demand-programs
      { program-id: program-id }
      {
        name: name,
        incentive-rate: incentive-rate,
        max-participants: max-participants,
        current-participants: u0,
        active: true
      }
    )
    (var-set next-program-id (+ program-id u1))
    (ok program-id)
  )
)

(define-public (enroll-in-program (program-id uint))
  (let ((program (unwrap! (map-get? demand-programs { program-id: program-id }) ERR_PROGRAM_NOT_FOUND)))
    (asserts! (is-none (map-get? participant-enrollments { participant: tx-sender, program-id: program-id })) ERR_ALREADY_ENROLLED)
    (asserts! (< (get current-participants program) (get max-participants program)) ERR_NOT_AUTHORIZED)

    ;; Enroll participant
    (map-set participant-enrollments
      { participant: tx-sender, program-id: program-id }
      {
        enrolled-at: block-height,
        total-savings: u0,
        participation-count: u0
      }
    )

    ;; Update program participant count
    (map-set demand-programs
      { program-id: program-id }
      (merge program { current-participants: (+ (get current-participants program) u1) })
    )

    (ok true)
  )
)

(define-public (record-participation (program-id uint) (energy-reduced uint))
  (let (
    (program (unwrap! (map-get? demand-programs { program-id: program-id }) ERR_PROGRAM_NOT_FOUND))
    (enrollment (unwrap! (map-get? participant-enrollments { participant: tx-sender, program-id: program-id }) ERR_NOT_AUTHORIZED))
    (savings (* energy-reduced (get incentive-rate program)))
  )
    (map-set participant-enrollments
      { participant: tx-sender, program-id: program-id }
      (merge enrollment {
        total-savings: (+ (get total-savings enrollment) savings),
        participation-count: (+ (get participation-count enrollment) u1)
      })
    )
    (ok savings)
  )
)

;; Read-only functions
(define-read-only (get-demand-program (program-id uint))
  (map-get? demand-programs { program-id: program-id })
)

(define-read-only (get-participant-enrollment (participant principal) (program-id uint))
  (map-get? participant-enrollments { participant: participant, program-id: program-id })
)
