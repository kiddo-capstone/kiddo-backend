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
        UserMailer.with(user: user).welcome_email.deliver_later
      else
        render json: { data: { errors: user.errors.full_messages.to_sentence, status: 400 } },
               status: :bad_request
      end
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

  def stats
    user = User.find_by(id: params[:id])
    if user
      render json: user.user_stats
    else
      errors = "Unable to get user stats"
      json_errors(errors, :bad_request)
    end
  end

  private

  def json_create(task)
    render json: UserSerializer.new(task)
  end

  def user_params
    params.permit(:name, :email, :updated_at)
  end

  
end
