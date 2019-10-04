class TasksController < ApplicationController
  before_action :set_id, only: [:edit, :destroy, :update, :show]
  before_action :login_check
  before_action :user_check, only:[:show, :edit, :update]

  def index
    mass = 10
    # @state_list = [["進行状況",nil]]
    # State.all.each do |s|
    #   @state_list << [s.progress,s.id]
    # end
    @state_list = set_state_array.unshift(["進行状況",nil])
    @tag_list = set_tag_array.unshift(["ラベル",nil])
    set_priority_array
    if params[:direction].present?
      @sort_type = params[:sort_type]
      @direction = params[:direction]
      if params[:search][:flag]
        @search_btn = true
        @search_mode = params[:search][:search_mode]
        array_augment = []
        array_result = []
        if params[:search][:progress_type].present?
          array_progress = []
          progress_id = params[:search][:progress_type]
          State.search_progress(progress_id, current_user.id).each do |task|
            array_progress << task.id
          end
          array_augment << array_progress
          @progress_type = progress_id
        end
        if params[:search][:tag].present?
          array_labels = Label.where(tag_id: params[:search][:tag]).pluck(:task_id)
          array_augment << array_labels
          @tag_type = params[:search][:tag]
        end
        params[:search][:item].each do |key,value|
          if value.present?
            array_item = []
            Task.where(user_id: current_user.id ,"#{key}": value.to_i).each do |task|
              array_item << task.id
            end
            array_augment << array_item
          end
          case key
          when "priority" then
            @priority_type = value
          end
        end
        if params[:search][:search_mode] == "and"
          case array_augment.size
          when 0 then
            array_result
          when 1 then
            array_result = array_augment
          else
            array_result = array_augment[0]
            for num in 1..(array_augment.size - 1) do
              array_result = (array_result & array_augment[num])
              array_result.uniq
            end
          end
          @search_mode = params[:search][:search_mode]
        else
          array_result = array_augment.flatten.uniq
        end

        @mass_tasks = Task.where(user_id: current_user.id).result_task(array_result,@sort_type,@direction)

      else
        @mass_tasks = Task.where(user_id: current_user.id).sort_task(@sort_type,@direction)
      end
    else
      @sort_type = "id"
      @direction = "asc"
      @mass_tasks = Task.where(user_id: current_user.id)
    end
    if @mass_tasks.present?
      @tasks = @mass_tasks.includes(:label_tag, :status_state).page(params[:page]).per(mass)

    else
      @tasks = []
    end
  end

  def show
    set_priority_array
  end

  def new
    @state_list = set_state_array
    @task = Task.new
    @task.statuses.build
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
    @state = @task.status_state[0]
    @state_list = set_state_array
  end

  def update
    @task.update(update_task_params)
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
    params.require(:task).permit(:id, :title, :comment, :deadline, :priority, :user_id, tag_ids:[], statuses_attributes:[:task_id, :state_id])
  end

  def update_task_params
    params.require(:task).permit(:id, :title, :comment, :deadline, :priority, :user_id, tag_ids:[], statuses_attributes:[:id, :task_id, :state_id])
  end

  def set_id
    @task = Task.find(params[:id])
  end

  def login_check
    unless current_user.present?
      redirect_to new_session_path
    end
  end

  def user_check
    unless Task.find(params[:id]).user_id == current_user.id
      redirect_to tasks_path
    end
  end

  def set_state_array
    State.pluck(:progress,:id)
  end

  def set_tag_array
    Tag.pluck(:name,:id)
  end

  def set_priority_array
    @prioritys = []
    Task.priority_ids.each do |key,value|
      @prioritys << key[0]
    end
  end
end
