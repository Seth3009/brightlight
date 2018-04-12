class Api::GatesController < Api::BaseController

  def create
    if params[:id].present?
      @badge = Badge.where(code:params[:id]).select('badges.*').first
      if @badge.present?
        if @badge.kind = "Employee"
          @employee = Employee.joins('left join badges on badges.employee_id = employees.id')
                    .select('employees.*,badges.*').where(badges: {code: params[:id]}).first
          if @employee.present?
            DoorAccessLog.insert_door_log(@employee.employee_id, @employee.kind, params[:id],params[:loc],@employee.name)
            response.header["result"] = '{code:' + @employee.code + ' name:' + @employee.name + ' kind:' + @employee.kind + '}'
          else
            @student = Student.joins('left join badges on badges.student_id = students.id')
                    .select('students.*,badges.*').where(badges: {code: params[:id]}).first
            if @student.present?
              DoorAccessLog.insert_door_log(@student.student_id, @student.kind, params[:id],params[:loc],@student.name)
              response.header["result"] = '{code:' + @student.code + ' name:' + @student.name + ' kind:' + @student.kind + '}'          
            end
          end
        end
      else
        response.header["result"] = '{Invalid Card}'
      end    
    end
  end
end
