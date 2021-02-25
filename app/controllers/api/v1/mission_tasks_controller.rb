
class Api::V1::MissionTasksController < ApplicationController
  before_action :set_s3_direct_post, only: [:update]

  def show
    json_create(MissionTask.find(params[:id]))
  end

  def create 
    mission_task = MissionTask.new(mission_task_params)
    if mission_task.save
      json_create(mission_task)
    else 
      errors = mission_task.errors.full_messages.to_sentence
      json_errors(errors, :bad_request)
    end
  end 


  def index
    tasks = Mission.get_tasks(params[:id])
    if tasks
      render json: MissionTaskListSerializer.new(tasks)
    else
      errors = "mission does not exist."
      json_errors(errors, :bad_request)
    end
  end

  def update 
    require 'pry'; binding.pry
    mission_task = MissionTask.find_by(id: params[:id])
    if mission_task 
      mission_task.update(mission_task_params)
      render json: { message: 'sucessfully updated mission task!' }
    else 
      errors = "mission task does not exist."
      json_errors(errors, :bad_request)
    end
  end 

  def destroy
    MissionTask.destroy(params[:id])
  end 


  private 

  def json_create(mission_task)
    render json: MissionTaskSerializer.new(mission_task)
  end

  def mission_task_params
    params.permit(:is_completed, :message, :mission_id, :task_id, :image_path)
  end

  def set_s3_direct_post
    s3 = Aws::S3::Resource.new(region: 'us-west-2')
    #image_file = File.read('spec/fixtures/new_math.png')

    # my_bucket = s3.bucket('wills-bucket')
    # my_bucket.create
    name = File.basename "#{params[:image][:original_filename]}"
    s3_bucket = s3.bucket('wills-bucket')
    obj2 = s3_bucket.objects(params[:original_filename])
    require 'pry'; binding.pry
    obj = s3.bucket('wills-bucket').object(name)
    require 'pry'; binding.pry
    obj.upload_file("#{params[:image][:tempfile]}")
    #obj.upload_file("#{params[:image][:tempfile]}",'wills-bucket',"#{params[:image][:original_filename]}")
    
    
    require 'pry'; binding.pry
    #s3_direct_post = s3.presigned_post(key: "uploads/#{SecureRandom.uuid}/${params[:image][:original_filename]}", success_action_status: '201', acl: 'public-read')
  end
end
