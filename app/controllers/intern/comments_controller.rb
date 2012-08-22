# encoding: utf-8
class Intern::CommentsController < InternController
  def create
    @question = Question.find params[:question_id]
    @comment = @question.comments.new params[:comment].merge :author => current_intern_user
    if @comment.save
      redirect_to intern_question_path @question
      flash[:success] = 'Dein Kommentar wurde erfolgreich veröffentlicht'
    else
      render 'intern/questions/show'
    end
  end
end
