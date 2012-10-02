# encoding: utf-8
class Intern::AttachmentsController < InternController
  before_filter :find_attachable

  def create
    authorize! :add_attachment, @attachable
    @attachment = @attachable.attachments.new params[:attachment]

    if @attachment.save
      redirect_to :controller => @attachable.class.to_s.pluralize.downcase, :action => :show, :id => @attachable.id
      flash[:success] = 'Deine Datei wurde erfolgreich hochgeladen'
    else
      instance_variable_set "@#{@attachable.class.to_s.downcase}", @attachable
      render "intern/#{@attachable.class.to_s.pluralize}/show"
    end
  end

  def destroy
    authorize! :remove_attachment, @attachable
    @attachment = @attachable.attachments.find params[:id]

    if @attachment.destroy
      flash[:success] = "Die Datei wurde erfolgreich gelöscht"
    else
      flash[:error] = "Die Datei konnte nicht gelöscht werden"
    end

    redirect_to :controller => @attachable.class.to_s.pluralize.downcase, :action => :show, :id => @attachable.id
  end

  private
  def find_attachable
    if params[:project_id]
      @attachable = Project.find params[:project_id]
    elsif params[:question_id]
      @attachable = Question.find params[:question_id]
    end
  end
end
