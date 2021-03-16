class Api::V1::UsersController < ApplicationController
  def index
    json_create(User.all)
  end

  def show
    json_create(User.find(params[:id]))
  end

  def create
    user = User.new(user_params)
    if user.save
      json_create(user)
    else
      render json: { data: { errors: user.errors.full_messages.to_sentence, status: 400 } },
              status: :bad_request
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    if user&.destroy
      json_create(user)
    else
      errors = "Unable to destroy user."
      json_errors(errors, :bad_request)
    end
  end

  private

  def json_create(task)
    render json: UserSerializer.new(task)
  end

  def user_params
    params.permit(:name, :updated_at)
  end
end
