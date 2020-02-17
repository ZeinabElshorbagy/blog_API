class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:update, :delete]

  def create
    Comment.new(content: comment_params[:content], user_id: current_user.id,
                post_id: params[:id]).save!
    render status: :ok
  end

  def update
    authorize @comment
    @comment.content = comment_params[:content]
    @comment.save!
    render status: :ok
  end

  def delete
    authorize @comment
    @comment.destroy
    render status: :ok
  end

  private
  def comment_params
    params.permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
