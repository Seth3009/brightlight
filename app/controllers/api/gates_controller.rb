class Api::GatesController < Api::BaseController

  def create
    if params[:id].present?
      @badge = Badge.find_by_code(params[:id])
      if @badge.present?
        if @badge.kind = "Employee"
          @person = Employee.joins('left join badges on badges.employee_id = employees.id')
                    .select('employees.*,badges.*').where(badges: {code: params[:id]}).first
          if @person.present?
            DoorAccessLog.insert_door_log(@person.employee_id, @badge.kind, params[:id],params[:loc],@person.name)
            response.header["result"] = '{code:' + @person.code + ' name:' + @person.name + ' kind:' + @badge.kind + '}'          
          end
        elsif
          @person = Student.joins('left join badges on badges.student_id = students.id')
                    .select('students.*,badges.*').where(badges: {code: params[:id]}).first
          if @person.present?
            DoorAccessLog.insert_door_log(@person.student_id, @badge.kind, params[:id],params[:loc],@person.name)
            response.header["result"] = '{code:' + @person.code + ' name:' + @person.name + ' kind:' + @badge.kind + '}'          
          end
        end
      else
        response.header["result"] = '{Invalid Card}'
      end
      
    else
      #response.header["X-result"] = '{Invalid Card}'
    end
  end
end
