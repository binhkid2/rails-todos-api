module Api
  module V1
    class TasksController < ApplicationController
      # If you have CSRF issues when calling from frontend tools, uncomment:
       protect_from_forgery with: :null_session

      def index
        page = params.fetch(:page, "0").to_i
        size = params.fetch(:size, "10").to_i
        size = 10 if size <= 0
        page = 0 if page < 0

        total_elements = Task.count
        total_pages = (total_elements.to_f / size).ceil
        offset = page * size

        tasks = Task.order(created_at: :desc).offset(offset).limit(size)
        number_of_elements = tasks.size

        render json: {
          content: tasks.map { |t| task_json(t) },
          totalElements: total_elements,
          totalPages: total_pages,
          size: size,
          number: page,
          first: page.zero?,
          last: (page >= (total_pages - 1)) || total_pages.zero?,
          numberOfElements: number_of_elements,
          empty: number_of_elements.zero?
        }
      end

      def show
        task = Task.find(params[:id])
        render json: task_json(task)
      end

      def create
        task = Task.new(task_params)
        if task.save
          render json: task_json(task), status: :created
        else
          render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        task = Task.find(params[:id])
        if task.update(task_params)
          render json: task_json(task)
        else
          render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        Task.find(params[:id]).destroy
        head :no_content
      end

      private

      def task_params
        # NestJS sends flat DTO; accept both {title:..} or {task:{title:..}}
        p = params[:task].is_a?(ActionController::Parameters) ? params.require(:task) : params
        p.permit(:title, :description, :completed)
      end

      def task_json(task)
        {
          id: task.id,
          title: task.title,
          description: task.description,
          completed: task.completed,
          createdAt: task.created_at&.utc&.iso8601(3)
        }
      end
    end
  end
end
