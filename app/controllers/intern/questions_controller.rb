# encoding: utf-8
class Intern::QuestionsController < InternController
  authorize_resource

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

  def edit
    @question = Question.find params[:id]
  end

  def update
    @question = Question.find params[:id]
    if @question.update_attributes params[:question]
      redirect_to intern_question_path @question
      flash[:success] = 'Deine Änderungen wurden erfolgreich gespeichert'
    else
      render :edit
    end
  end
end
