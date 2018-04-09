class Api::GatesController < Api::BaseController

  def create
    if params[:card] == "1234"
      #response.header["X-result"] = '{"id":1,"card":"1037113638","employee_id":70,"created_at":"2018-03-14T11:20:26.436+07:00","updated_at":"2018-04-05T09:45:57.089+07:00"}'
      render json: '{"id":1,"card":"1037113638","employee_id":70,"created_at":"2018-03-14T11:20:26.436+07:00","updated_at":"2018-04-05T09:45:57.089+07:00"}'
    else
      #response.header["X-result"] = '{"error":"invalid"}'
      render json: '{"error":"invalid"}'
    end
  end
end
