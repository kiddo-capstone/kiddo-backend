class ApplicationController < ActionController::API

private

  def json_errors(errors, response_status)
    render json: { data: { errors: errors, status: response_status } }, status: response_status
  end

end
