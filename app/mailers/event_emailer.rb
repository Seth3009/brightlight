class EventEmailer < ActionMailer::Base
  default from: "Brightlight <brightlight@cahayabangsa.org>"

  def approval(addressee, events)
    @addressee = addressee
    @events = Event.find(events)
    mail(to: @addressee, subject: "Approval required for events")
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