# encoding: utf-8
class Intern::CommentsController < InternController
  def create
    @post = Post.find params[:post_id]
    @comment = @post.comments.new params[:comment]
    @comment.author = current_intern_user
    if @comment.save
      redirect_to intern_post_path @post
      flash[:success] = 'Dein Kommentar wurde erfolgreich veröffentlicht'
    else
      render 'intern/posts/show'
    end
  end
end
