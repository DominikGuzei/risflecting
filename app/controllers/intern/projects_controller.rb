# encoding: utf-8
class Intern::ProjectsController < InternController
  def new
    @project = current_intern_user.projects.new
  end

  def create
    @project = current_intern_user.projects.new params[:project]
    if @project.save
      redirect_to intern_project_path @project
      flash[:success] = 'Deine Erfahrung wurde erfolgreich veröffentlicht'
    else
      render :new
    end
  end

  def index
  end

  def show
    @project = Project.find params[:id]
  end
end
