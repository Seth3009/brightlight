class EventEmailer < ActionMailer::Base
  default from: "Brightlight <brightlight@cahayabangsa.org>"

  def approval(event)
    @event = event
    @cc = [event.creator, event.manager].map {|person| %("#{person.name}" <#{person.email}>)}
    approvers = @requisition.approvals.level(level)
    @addressee = approvers.map { |approval| %("#{approval.approver.employee.name}" <#{approval.approver.employee.email}>) }
    mail(to: @addressee, cc: @cc, subject: "Approval required: Event #{event.name}.")
  end


  def not_approved(event)
    @event = event
    @people = [event.creator, event.manager].map {|person| %("#{person.name}" <#{person.email}>)}
    mail(to: @people, subject: "Event #{event.name} is not approved.")
  end

  def approved(event)
    @event = event
    @people = [event.creator, event.manager].map {|person| %("#{person.name}" <#{person.email}>)}
    mail(to: @people, subject: "Event #{event.name} has been approved.")
  end 
end