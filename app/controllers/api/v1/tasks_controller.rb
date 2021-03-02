class Api::V1::TasksController < ApplicationController
  def index
    json_create(Task.all)
  end

  def show
    json_create(Task.find(params[:id]))
  end

  def create
    task = Task.new(task_params)
    if task.save
      json_create(task)
    else
      render json: { data: { errors:
        task.
        errors.
        full_messages.
        to_sentence,
        status: 400 } },
        status: :bad_request
    end
  end

  def update
    task = Task.find(params[:id])

    if task.update(task_params)
      render json: { message: 'success' }
    else
      render json: { data: { errors:
        task.
        errors.
        full_messages.
        to_sentence,
        status: 400 } },
        status: :bad_request
    end
  end

  def destroy
    task = Task.find_by(id: params[:id])
    if task&.destroy
      json_create(task)
    else
      errors = "Unable to destroy task."
      json_errors(errors, :bad_request)
    end

  end

  private

  def json_create(item)
    render json: TaskSerializer.new(item)
  end

  def task_params
    params.permit(:name, :description, :category, :points, :resource_alt, :resourse_link, :resource_type)
  end
end
