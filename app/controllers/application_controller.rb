class ApplicationController < ActionController::API

private

  def json_errors(errors, response_status)
    render json: { data: { errors: errors, status: response_status } }, status: response_status
  end

  def auth_check
    user_params = JSON.parse(request.body.read, symbolize_names: true)
    user = User.find_by(email: user_params[:email])
    unless user.auth_token == user_params[:auth_token]
      render json: { message: 'unsuccessful', error: 'Missing Auth Token' }
    end
  end
end
