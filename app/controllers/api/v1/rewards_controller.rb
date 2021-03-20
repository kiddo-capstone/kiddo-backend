class Api::V1::RewardsController < ApplicationController

  def index
    json_create(Reward.where(user_id: params[:user_id])) if params[:user_id]
    json_create(Reward.where(parent_id: params[:parent_id])) if params[:parent_id]
  end

  def show
    json_create(Reward.find(params[:id]))
  end

  def create
    reward = Reward.new(reward_params)
    if reward.save
      json_create(reward)
    else
      render json: { data: { errors: reward.errors.full_messages.to_sentence, status: 400 } },
              status: :bad_request
    end
  end

  def update
    reward = Reward.find_by(id: params[:id])
    if reward&.update(reward_params)
      reward.user.update_points(reward.points_to_redeem) if params[:redeemed] && reward.redeemed
      json_create(reward)
    else
      errors = reward.errors.full_messages.to_sentence
      json_errors(errors, :bad_request)
    end
  end

  def destroy
    reward = Reward.find_by(id: params[:id])
    if reward&.destroy
      json_create(reward)
    else
      errors = "Unable to destroy reward."
      json_errors(errors, :bad_request)
    end
  end

  private

  def json_create(task)
    render json: RewardSerializer.new(task)
  end

  def reward_params
    params.permit(:title, :description, :parent_id, :user_id, :redeemed, :points_to_redeem)
  end


end
