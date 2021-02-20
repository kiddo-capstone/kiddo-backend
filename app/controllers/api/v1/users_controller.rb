class Api::V1::UsersController < ApplicationController
  def index
    json_create(User.all)
  end

  def show
    json_create(User.find(params[:id]))
  end

  def create
    if User.find_by(email: params[:email])
      json_create(User.find_by(email: params[:email]))
    else
      user = User.new(user_params)
      if user.save
        json_create(user)
      else
        render json: { data: { errors: user.errors.full_messages.to_sentence, status: 400 } },
               status: :bad_request
      end
    end
  end

  def destroy
    User.destroy(params[:id])
  end

  private

  def json_create(task)
    render json: UserSerializer.new(task)
  end

  def user_params
    params.permit(:name, :email, :updated_at)
  end
end
