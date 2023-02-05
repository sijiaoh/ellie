class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = policy_scope(Post).includes(:author).page(params[:page])
    authorize @posts
  end

  def show; end

  def new
    @post = Post.new(editor_type: current_user.setting.editor_type)
    authorize @post
    skip_policy_scope
  end

  def edit; end

  def create
    @post = Post.new(post_params.merge(author: current_user))
    authorize @post
    skip_policy_scope

    if @post.save
      redirect_to @post, notice: notice_message(Post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: notice_message(Post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: notice_message(Post)
  end

  private

  def set_post
    @post = policy_scope(Post).find_by!(hashid: params[:hashid])
    authorize @post
  end

  def post_params
    params.require(:post).permit(:title, :content, :published)
  end
end
