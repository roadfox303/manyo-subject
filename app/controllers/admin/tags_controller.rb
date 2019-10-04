class Admin::TagsController < ApplicationController
  before_action :authority_check
  before_action :set_tag, only: [:destroy, :update]

  def index
    @tags = Tag.all.reverse
  end

  def create
    @tag = Tag.new(name:params[:name])
    if @tag.save
      flash[:success] = "ラベル用タグを作成しました"
      redirect_to admin_tags_path
    else
      flash[:failure] = "ラベル用タグの作成に失敗しました"
      render 'index'
    end
  end

  def update
    if @tag.update(tag_params)
      flash[:success] = "ラベル用タグを編集しました"
      redirect_to admin_tags_path
    else
      flash[:failure] = "ラベル用タグの編集に失敗しました"
      render 'index'
    end
  end

  def destroy
    if @tag.destroy
      flash[:success] = t('flash.admins.user_deleted')
    else
      flash[:failure] = t('flash.admins.failed_user_delete')
    end
    redirect_to admin_tags_path
  end

  private

  def tag_params
  params.require(:tag).permit(:name)
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def authority_check
    raise Forbidden unless current_admin.present?
  end
end
