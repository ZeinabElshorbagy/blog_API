class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:update, :delete, :update_tags, :show]

  def index
    render json: {posts: Post.all.as_json(include: [:tags, :comments])}, status: :ok
  end

  def create
    if post_params[:tags].nil? ||  post_params[:tags].empty?
      render json: "tags cannot be blank", status: :bad_request
    else 
      @post = Post.create(title: post_params[:title], body: post_params[:body], user_id: current_user.id)
      TagsService.create_post_tags(post_params[:tags], @post.id)
      render json: {post: @post.as_json(include: :tags)}, status: :created
    end
  end

  def show
    render json: {post: @post.as_json(include: [:tags, :comments])}, status: :ok
  end
  
  def update
    authorize @post
    @post.title = update_params[:title] unless update_params[:title].nil? || update_params[:title].empty?
    @post.body = update_params[:body] unless update_params[:body].nil? || update_params[:body].empty?
    @post.save!
    render json: {post: @post.as_json(include: :tags)}, status: :ok
  end

  def delete
    authorize @post
    Tag.where("post_id = ?", @post.id).delete_all
    Comment.where("post_id = ?", @post.id).delete_all
    @post.delete
    render json: "post deleted successfully", status: :ok
  end

  def update_tags
    authorize @post
    TagsService.update(update_tags_params[:tags], @post.id)
    render json: {post: @post.as_json(include: :tags)}, status: :ok
  end

  private
  def post_params
    params.permit(:title, :body, tags: [])
  end

  def update_params
    params.permit(:title, :body)
  end

  def update_tags_params
    params.permit(tags: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
