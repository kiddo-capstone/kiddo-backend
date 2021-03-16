class Api::V1::ParentsController < ApplicationController
    def index
      json_create(Parnet.all)
    end
  
    def show
      json_create(Parent.find(params[:id]))
    end
  
    def create
      if Parent.find_by(email: params[:email])
        json_create(Parent.find_by(email: params[:email]))
      else
        parent = Parent.new(parent_params)
        if parent.save
          json_create(parent)
          ParentMailer.with(parent: parent).welcome_email.deliver_later
        else
          render json: { data: { errors: parent.errors.full_messages.to_sentence, status: 400 } },
                 status: :bad_request
        end
      end
    end
  
    def destroy
      parent = Parent.find_by(id: params[:id])
      if parent&.destroy
        json_create(parent)
      else
        errors = "Unable to destroy parent."
        json_errors(errors, :bad_request)
      end
    end
  
    private
  
    def json_create(task)
      render json: ParentSerializer.new(task)
    end
  
    def parent_params
      params.permit(:name, :email, :updated_at, :created_at)
    end
  end
  