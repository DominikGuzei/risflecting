# encoding: utf-8
class Intern::PostsController < InternController
  def index
    @posts = Post.order(:updated_at).reverse_order
  end

  def show
    @post = Post.find params[:id]
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_intern_user.posts.new params[:post]
    if @post.save
      redirect_to intern_post_path @post
      flash[:success] = 'Deine Frage/Mitteilung wurde erfolgreich veröffentlicht'
    else
      render :new
    end
  end
end
