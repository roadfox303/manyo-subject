class Admin::UsersController < ApplicationController
  before_action :authority_check
  before_action :set_user, only: [:edit, :destroy, :update, :show]
  PER = 20

  def new
    @user = User.new
  end

  def index
    @admins = []
    Admin.all.each do |user|
      @admins << user.user_id
    end
    @users = User.includes(:tasks).page(params[:page]).per(PER)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t('flash.admins.user_created')
      redirect_to admin_users_path
    else
      flash[:failure] = t('flash.admins.failed_user_create')
      render 'new'
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t('flash.admins.user_deleted')
    else
      flash[:failure] = t('flash.admins.failed_user_delete')
    end
    redirect_to admin_users_path
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = t('flash.admins.user_edited')
      redirect_to admin_users_path
    else
      flash[:failure] = t('flash.admins.failed_user_edit')
      render 'edit'
    end
  end

  def add
    unless Admin.find_by(user_id: admin_params[:user_id]).present?
      @admin = Admin.new(user_id: admin_params[:user_id])
      if @admin.save
        flash[:success] = t('flash.admins.created')
      else
        flash[:failure] = t('flash.admins.failed_create')
      end
    else
      flash[:failure] = t('flash.admins.augment_authority')
    end
    redirect_to admin_users_path
  end

  def remove
    @admin = Admin.find_by(user_id: admin_params[:user_id])
    if Admin.all.size > 1
      if @admin.destroy
        flash[:success] = t('flash.admins.deleted')
      else
        flash[:failure] = t('flash.admins.failed_delete')
      end
    else
      flash[:failure] = t('flash.admins.cant_delete')
    end
    redirect_to admin_users_path
  end

  private
  def admin_params
    params.permit(:user_id, :id)
  end

  def authority_check
    raise Forbidden unless current_admin.present?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
