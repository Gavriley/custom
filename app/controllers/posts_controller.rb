class PostsController < ApplicationController

  def show

  end

  def new
    @post = Post.includes(:custom_fields).new

    @post.custom_fields.build kind: :desc, order: 1
    @post.custom_fields.build kind: :role, order: 2
    @post.custom_fields.build kind: :link, order: 3
  end

  def create
    @post = Post.new post_params

    if @post.save
      redirect_to edit_post_path(@post), notice: 'Successfully create'
    else
      redirect_to new_post_path, notice: @post.errors.full_messages.first
    end
  end

  def edit
    @post = Post.includes(:custom_fields).find params[:id]
    @count = @post.custom_fields.size
  end

  def update
    @post = Post.includes(:custom_fields).find params[:id]

    if @post.update_attributes post_params
      redirect_to edit_post_path(@post), notice: 'Successfully update'
    else
      redirect_to edit_post_path(@post), notice: @post.errors.full_messages.first
    end
  end

  def create_field; end

  def create_role
    @value = params[:value]
    @index = params[:index].to_i
  end

  private

  def post_params
    params.require(:post).permit(:title,
                                        custom_fields_attributes: [:id, :name, :value, :kind, :order, :_destroy,
                                        children_attributes: [:id, :name, :value, :kind, :order, :_destroy]])
  end

end
