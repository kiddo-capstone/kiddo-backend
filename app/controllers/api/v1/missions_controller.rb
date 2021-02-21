class Api::V1::MissionsController < ApplicationController

  def index
    json_create(Mission.all)
  end

  def show
    mission = Mission.find_by(id: params[:id])
    if mission
      json_create(mission)
    else
      errors = "Unable to find mission"
      json_errors(errors, :bad_request)
    end
  end

  def create
    mission = Mission.new(mission_params)
    if mission.save
      json_create(Mission.last)
    else
      errors = mission.errors.full_messages.to_sentence
      json_errors(errors, :bad_request)
    end
  end

  def update
    mission = Mission.find_by(id: params[:id])
    if mission && mission.update(mission_params)
      json_create(mission)
    else
      errors = "Unable to update mission. #{mission.errors.full_messages.to_sentence}"
      json_errors(errors, :bad_request)
    end
  end

  def destroy
    mission = Mission.find_by(id: params[:id])
    if mission
      json_create(mission.destroy)
    else
      errors = "Unable to destroy mission."
      json_errors(errors, :bad_request)
    end
  end

  private

  def json_create(obj)
    render json: MissionSerializer.new(obj)
  end

  def mission_params
    params.permit(:name, :due_date, :user_id)
  end
end

