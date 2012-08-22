class Intern::AttachmentsController < InternController
  def create
    @question = Question.find params[:question_id]
    authorize! :add_attachment, @question

    @attachment = @question.attachments.new params[:attachment]

    if @attachment.save
      redirect_to intern_question_path @question
      flash[:success] = 'Deine Datei wurde erfolgreich hochgeladen'
    else
      render 'intern/questions/show'
    end
  end
end
