class TasksController < ApplicationController
  before_action :set_id, only: [:edit, :destroy, :update, :show]

  def index
    @tasks = Task.all.reverse
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    Task.create(task_params)
    #下記は user_id をテスト指定（ユーザー機能と連携時にはuserインスタンスから取得）
    flash[:success] = "タスクを登録しました"
    redirect_to tasks_path
  end

  def edit
  end

  def update
    @task.update(task_params)
    flash[:success] = "タスクを編集しました"
    redirect_to tasks_path
  end

  def destroy
    @task.destroy
    flash[:success] = "タスクを削除しました"
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
