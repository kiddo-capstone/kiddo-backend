class Api::V1::MissionsController < ApplicationController

  def index
    json_create(Mission.all)
  end

  private

  private

  def json_create(obj)
    render json: MissionSerializer.new(obj)
  end
end

