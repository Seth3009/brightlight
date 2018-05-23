select bc.id, bc.barcode, bc.book_condition_id, cc.id, cc.book_condition_id, cc.academic_year_id
from book_copies bc
join copy_conditions cc on (bc.id = cc.book_copy_id)
left outer join copy_conditions cc2 on (bc.id = cc2.book_copy_id and
	(cc.created_at < cc2.created_at))
where cc2.id is null and bc.book_condition_id != cc.book_condition_id 
and cc.academic_year_id > 15
order by bc.barcode
