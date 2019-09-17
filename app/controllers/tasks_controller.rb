class TasksController < ApplicationController
  before_action :set_id, only: [:edit, :destroy, :update, :show]

  def index
    if params[:direction].present?
      @sort_type = params[:sort_type]
      @direction = params[:direction]
      @tasks = Task.all.order("#{@sort_type} #{@direction}")
    else
      @sort_type = "id"
      @direction = "asc"
      @tasks = Task.all
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
      @task = Task.create(task_params)
    if @task.save
      flash[:success] = t('flash.tasks.created')
      redirect_to tasks_path
    else
      flash[:failure] = t('flash.tasks.failed_create')
      render :new
    end
  end

  def edit
  end

  def update
    @task.update(task_params)
    if @task.save
      flash[:success] = t('flash.tasks.edited')
      redirect_to tasks_path
    else
      flash[:failure] = t('flash.tasks.failed_edit')
      render :new
    end
  end

  def destroy
    @task.destroy
    flash[:success] = t('flash.tasks.deleted')
    redirect_to tasks_path
  end

  private
  def task_params
    params.require(:task).permit(:id, :title, :comment,:deadline)
  end

  def set_id
    @task = Task.find(params[:id])
  end
end
