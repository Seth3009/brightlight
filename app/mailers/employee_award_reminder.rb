class EmployeeAwardReminder < ActionMailer::Base
  default from: "brightlight@cahayabangsa.org",
          bcc: "medhiwidjaja@cahayabangsa.org"
  
  def sample_email
    @user = Employee.find_by_name 'Medhi Widjaja'
    mail(to: %("#{@user.name}" <#{@user.email}>), subject: 'Another Sample Email')
  end

end
