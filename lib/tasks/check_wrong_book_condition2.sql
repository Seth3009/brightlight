SELECT bc.id, bc.barcode, bc.book_condition_id, cc.book_condition_id, cc.academic_year_id
FROM book_copies bc
JOIN copy_conditions cc ON (
       bc.id = cc.book_copy_id
   AND NOT EXISTS (
     SELECT 1 FROM copy_conditions cc1
     WHERE cc1.book_copy_id = bc.id
     AND cc1.id > cc.id
   )
   AND bc.book_condition_id != cc.book_condition_id
   AND cc.academic_year_id > 15
)
ORDER BY bc.barcode