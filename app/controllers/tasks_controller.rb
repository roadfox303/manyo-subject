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
    Task.create(task_params)
    #下記は user_id をテスト指定（ユーザー機能と連携時にはuserインスタンスから取得）
    flash[:success] = t('flash.tasks.created')
    redirect_to tasks_path
  end

  def edit
  end

  def update
    @task.update(task_params)
    flash[:success] = t('flash.tasks.edited')
    redirect_to tasks_path
  end

  def destroy
    @task.destroy
    flash[:success] = t('flash.tasks.deleted')
    redirect_to tasks_path
  end

  private
  def task_params
    params.require(:task).permit(:id, :title, :comment)
  end

  def set_id
    @task = Task.find(params[:id])
  end
end
