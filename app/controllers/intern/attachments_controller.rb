class Intern::AttachmentsController < InternController
  def create
    @post = Post.find params[:post_id]
    authorize! :add_attachment, @post

    @attachment = @post.attachments.new params[:attachment]

    if @attachment.save
      redirect_to intern_post_path @post
      flash[:success] = 'Deine Datei wurde erfolgreich hochgeladen'
    else
      render 'intern/posts/show'
    end
  end
end
