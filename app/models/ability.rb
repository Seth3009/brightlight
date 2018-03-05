class Ability
  include CanCan::Ability

  def initialize(user)

		@user = user || User.new # guest user (not logged in)

		@user.roles << 'guest' if @user.new_record?

		# This one calls each method according to the roles
		@user.roles.each { |role| send(role.downcase) }
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
    can :update, Requisition do |req|
      req.budget_approver == @user.employee     # User can only approve requisition that is sent to the respective user
    end
    can :approve, Requisition do |req|
      req.supervisor == @user.employee          # User can only approve requisition that is sent to the respective user
    end
    can :approve_budget, Requisition do |req|
      req.budget_approver == @user.employee     # User can only approve requisition that is sent to the respective user
    end
    can :manage, Budget, budget_holder: @user.employee
    can :manage, BudgetItem do |budget_item| 
      budget_item.budget.budget_holder == @user.employee 
    end
    can :read, :all
    can_manage_own_leave_request
    can :review, LeaveRequest
    can [:approve, :read, :update], LeaveRequest do |lr|
      lr.employee.try(:department).try(:manager) == @user.employee   # Manager can only approve leave requests of employees in his/her department
    end
	end

  # Teacher
  def teacher
    can :manage, CourseSection, instructor: @user.employee
    can :manage, GradeSection, homeroom: @user.employee
    can :manage, StudentBook #, grade_section: GradeSection.find_by_homeroom_id(@user.employee)
    can :manage, StandardBook
    can :scan, BookLoan
    can :read, BookLoan
    can [:read,:create], LoanCheck
    can [:create,:read,:update,:destroy], Carpool
    can [:create], Requisition
    can [:manage], Requisition, requester: @user.employee
    can [:manage], ReqItem, requester: @user.employee
    can :read, :all
    can_manage_own_leave_request
  end

  def staff
    can [:create,:read,:update,:destroy], Carpool
    can :manage, Transport
    can [:manage], Requisition, requester: @user.employee
    can [:manage], ReqItem, requester: @user.employee
    can :read, :all
    can_manage_own_leave_request
  end

  def hrd
    can :manage, Employee
    can [:create, :update, :read, :read_hr, :destroy], LeaveRequest
    can :validate, LeaveRequest do 
      @user.employee == Department.find_by(code: 'HR').manager
    end
  end

  def carpool
    can [:manage], Carpool
    can :read, :all
  end

  def purchasing
    can [:manage], Requisition
    can [:manage], ReqItem
    can [:manage], PurchaseOrder
    can [:manage], OrderItem
    can [:manage], Supplier
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
      can [:create, :read, :cancel], LeaveRequest, employee: @user.employee
      can [:update, :destroy], LeaveRequest do |lr| lr.employee == @user.employee && lr.draft? end
    end

end
