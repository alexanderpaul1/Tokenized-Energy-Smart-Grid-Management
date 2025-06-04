;; Energy Distribution Contract
;; Manages smart grid energy distribution

(define-constant ERR_NOT_AUTHORIZED (err u200))
(define-constant ERR_INSUFFICIENT_ENERGY (err u201))
(define-constant ERR_INVALID_DISTRIBUTION (err u202))

;; Data structures
(define-map energy-pools
  { pool-id: uint }
  {
    total-energy: uint,
    available-energy: uint,
    price-per-unit: uint,
    created-at: uint
  }
)

(define-map distribution-records
  { record-id: uint }
  {
    from-pool: uint,
    to-address: principal,
    amount: uint,
    timestamp: uint
  }
)

(define-data-var next-pool-id uint u1)
(define-data-var next-record-id uint u1)

;; Public functions
(define-public (create-energy-pool (total-energy uint) (price-per-unit uint))
  (let ((pool-id (var-get next-pool-id)))
    (map-set energy-pools
      { pool-id: pool-id }
      {
        total-energy: total-energy,
        available-energy: total-energy,
        price-per-unit: price-per-unit,
        created-at: block-height
      }
    )
    (var-set next-pool-id (+ pool-id u1))
    (ok pool-id)
  )
)

(define-public (distribute-energy (pool-id uint) (amount uint) (recipient principal))
  (let (
    (pool (unwrap! (map-get? energy-pools { pool-id: pool-id }) ERR_INVALID_DISTRIBUTION))
    (record-id (var-get next-record-id))
  )
    (asserts! (>= (get available-energy pool) amount) ERR_INSUFFICIENT_ENERGY)

    ;; Update pool
    (map-set energy-pools
      { pool-id: pool-id }
      (merge pool { available-energy: (- (get available-energy pool) amount) })
    )

    ;; Record distribution
    (map-set distribution-records
      { record-id: record-id }
      {
        from-pool: pool-id,
        to-address: recipient,
        amount: amount,
        timestamp: block-height
      }
    )

    (var-set next-record-id (+ record-id u1))
    (ok record-id)
  )
)

;; Read-only functions
(define-read-only (get-energy-pool (pool-id uint))
  (map-get? energy-pools { pool-id: pool-id })
)

(define-read-only (get-distribution-record (record-id uint))
  (map-get? distribution-records { record-id: record-id })
)
