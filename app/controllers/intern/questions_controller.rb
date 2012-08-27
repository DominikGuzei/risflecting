# encoding: utf-8
class Intern::QuestionsController < InternController
  def index
    @questions = Question.includes(:comments).order(:updated_at).page(params[:page]).per(15).reverse_order
  end

  def show
    @question = Question.find params[:id]
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_intern_user.questions.new params[:question]
    if @question.save
      redirect_to intern_question_path @question
      flash[:success] = 'Deine Frage/Mitteilung wurde erfolgreich veröffentlicht'
    else
      render :new
    end
  end
end
