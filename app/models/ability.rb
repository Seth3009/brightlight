class Ability
  include CanCan::Ability

  def initialize(user)

		@user = user || User.new # guest user (not logged in)

		@user.roles << 'guest' if @user.new_record?

		# This one calls each method according to the roles
    @user.roles.each { |role| send(role.downcase) }
    can_view_own_account
  end

  # Admin user can do anything
	def admin
		can :manage, :all
	end

	# Inventory staff
	def inventory
		can :manage, BookTitle
		can :manage, BookEdition
		can :manage, BookCopy
    can :manage, BookCondition
    can :manage, CopyCondition
    can :manage, StudentBook
    can :manage, BookLoan
    can :manage, BookFine
    can :manage, BookLabel
    can :manage, StandardBook
    can :manage, Currency
    can :manage, GradeSection
    can :manage, Template
    can :manage, BookReceipt
    can :update, Student  # for nested form in StudentBook
    can :update, Employee # for nested form in BookLoan
    can :manage, BookLoan
    can :manage, Subject
    can :manage, LoanCheck
    can :read, :all
    can :manage, SuppliesTransaction
    can :manage, SuppliesTransactionItem
    can :manage, Product
    can :manage, ItemUnit
    can :manage, ItemCategory
    can :manage, BookCategory
	end

	def manager
    can :manage, CourseSection
    can :manage, GradeSection
    can :manage, StudentBook
    can :manage, StandardBook
    can [:create,:read,:update,:destroy], Carpool
    can [:create,:read,:update,:destroy], Requisition, department: @user.employee.department
    can :manage, ReqItem do |req_item| 
      req_item.requisition.department == @user.employee.department 
    end
    can_manage_own_requisition
    can :review, Requisition
    can :approve, Requisition do |req|
      req.approvers.map {|a| a.employee.id}.include? @user.employee.id          # User can only approve requisition that is sent to the respective user
    end
    can :manage, Budget, budget_holder: @user.employee
    can :manage, BudgetItem do |budget_item| 
      budget_item.budget.budget_holder == @user.employee 
    end
    can :read, :all
    can :read, PurchaseOrder, requestor: @user.employee
    can :review, LeaveRequest
    can [:approve, :read, :update], LeaveRequest do |lr|
      lr.employee.approver_id == @user.employee.id || lr.employee.approver_assistant_id == @user.employee.id  # Manager can only approve leave requests of employees in his/her department
    end
    can_manage_own_leave_request
    
	end

  # Teacher
  def teacher
    can :manage, CourseSection, instructor: @user.employee
    can :manage, GradeSection, homeroom: @user.employee
    can :manage, StudentBook #, grade_section: GradeSection.find_by_homeroom_id(@user.employee)
    can :manage, StandardBook
    can :scan, BookLoan
    can :return, BookLoan
    can :read, BookLoan
    can [:read,:create], LoanCheck
    can [:create,:read,:update,:destroy], Carpool
    can [:create,:read, :update, :destroy], Requisition, requester: @user.employee
    can :approve, Requisition do |req|
      req.approvers.map {|a| a.employee.id}.include? @user.employee.id         # User can only approve requisition that is sent to the respective user
    end
    can [:manage], ReqItem, requester: @user.employee
    can :read, :all
    can :read, PurchaseOrder, requestor: @user.employee
    can [:create,:read,:update], Event, creator: @user.employee
    can_manage_own_leave_request
    can_manage_own_requisition    
  end

  def staff
    can [:create,:read,:update,:destroy], Carpool
    can :manage, Transport
    can [:manage], ReqItem, requester: @user.employee
    can :read, :all
    can [:create,:read, :update, :destroy], Requisition, requester: @user.employee
    can :approve, Requisition do |req|
      req.approvers.includes(approver: :employee).map {|a| a.employee.id}.include? @user.employee.id          # User can only approve requisition that is sent to the respective user
    end
    can :read, PurchaseOrder, requestor: @user.employee
    can_manage_own_leave_request
    can_manage_own_requisition    
  end

  def hrd
    can :manage, Employee
    can [:create, :update, :read, :read_hr, :destroy, :cancel], LeaveRequest
    can :validate, LeaveRequest do 
      @user.employee == Department.find_by(code: 'HR').manager || @user.employee == Department.find_by(code: 'HR').vice_manager
    end   
    
  end

  def food_and_beverage
    can :manage, Food
  end
  
  def public_relations
    can :manage, StudentTardy
  end
  
  def carpool
    can [:manage], Carpool
    can :read, :all
  end

  def purchasing
    can [:create,:read,:update,:destroy, :process], Requisition
    can [:create,:read,:update,:destroy], ReqItem
    can [:create,:read,:update,:destroy], PurchaseOrder
    can [:create,:read,:update,:destroy], OrderItem
    can [:create,:read,:update,:destroy], Supplier
  end

  def buyer
  end

  def approve_budget
    can :approve_budget, Requisition
  end
  
  def administrative
    can :manage, DiknasReportCard
    can :read, DiknasConversion
    can :manage, DiknasConversion if @user.has_role? :manager 
    can :manage, DiknasConverted
    can :manage, DiknasCourse
    can :manage, Course
  end

  def student
    can :read, CourseSection
    can :read, GradeLevel
    can :read, GradeSection
    can :read, Course
  end

	# Guest, a non-signed in user, can only view public articles
	def guest
  end
  
  private 

    def can_manage_own_leave_request      
      can [:create, :read ], Comment, user: @user
      can [:create], LeaveRequest, employee: @user.employee 
      can [:update, :destroy], LeaveRequest do |lr| lr.employee == @user.employee && lr.draft? && lr.spv_approval.nil?end
    end

    def can_manage_own_requisition
      can [:create, :read, :cancel], Requisition, requester: @user.employee
      can [:update, :destroy], Requisition do |req| req.requester == @user.employee && req.draft? end
    end

    def can_view_own_account
      can [:read], User, id: @user.id 
    end   

end
