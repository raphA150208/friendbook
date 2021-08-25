class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    if params[:back]
      @post = Post.new(post_params)
    else
      @post = Post.new
    end
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    if params[:back]
      render :new
    else
        respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: "投稿しました" }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "編集しました" }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "削除しました" }
      format.json { head :no_content }
    end
  end
  def confirm
    @post = current_user.posts.build(post_params)
    render :new if @post.invalid?
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:content, :picture, :picture_cache)
    end
end
