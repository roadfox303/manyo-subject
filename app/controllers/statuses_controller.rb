class StatusesController < ApplicationController
  def create
    binding.pry
    # task = Task.find(params[:task_id])
    # task.statuses.create(state_id: params[:state_id].to_i)
    # redirect_to tasks_path(anchor: "task_#{params[:task_id]}")
  end

  def destroy
    # favorite = current_user.favorites.find_by(id: params[:id]).destroy
    # redirect_to articles_path(anchor: "article_#{params[:article_id]}"), notice: "#{favorite.article.user.name}さんの画像をお気に入り解除しました"
  end

end
