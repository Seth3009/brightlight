namespace :data do
	desc "Populate approvers"
  task populate_approvers: :environment do
    # Purchase Request
    Approver.create employee_id:430, department_id: nil, category: 'PR', level: 3 
    Department.where(id: [5,6,7,11,12]).each {|d| Approver.create employee_id:431, department_id:d.id, category: 'PR', level: 2 }
    Department.where(id: [1,2,3,5,8,9,10]).each {|d| Approver.create employee_id:46, department_id:d.id, category: 'PR', level: 2 }
    Employee.where(leaderships:true).each{|e| Approver.create employee_id:e.id, department_id:e.department_id, category: 'PR', level: 1 }
    Employee.where(leaderships:true).each{|e| Approver.create employee_id:e.id, department_id:e.department_id, category: 'LR', level: 1 }

    # Leave Request
    Approver.create employee_id:430, department_id: nil, category: 'LR', level: 2 
    Department.where(id: [5,6,7,11,12]).each {|d| Approver.create employee_id:431, department_id:d.id, category: 'PR', level: 2 }
    Department.where(id: [1,2,3,5,8,9,10]).each {|d| Approver.create employee_id:46, department_id:d.id, category: 'PR', level: 2 }
    Employee.where(leaderships:true).each{|e| Approver.create employee_id:e.id, department_id:e.department_id, category: 'PR', level: 1 }
    Employee.where(leaderships:true).each{|e| Approver.create employee_id:e.id, department_id:e.department_id, category: 'LR', level: 1 }

  end
end