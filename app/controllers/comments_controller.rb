class CommentsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @comments = @item.comments.includes(:user).order(created_at: :desc)
    @comment = Comment.new(comment_params)
    @user = User.find(@comment.user_id).nickname
    if @comment.valid?
      @comment.save
      ActionCable.server.broadcast 'comment_channel', content: @comment, user: @user, date: @comment.updated_at.strftime('%Y/%m/%d %H:%M:%C')
    else
      render 'items/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(item_id: params[:item_id], user_id: current_user.id)
  end
end
