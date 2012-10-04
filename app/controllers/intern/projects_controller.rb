# encoding: utf-8
class Intern::ProjectsController < InternController
  authorize_resource

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
    @projects = Project.order(:updated_at).reverse_order
  end

  def show
    @project = Project.find params[:id]
  end

  def edit
    @project = Project.find params[:id]
  end

  def update
    @project = Project.find params[:id]

    if @project.update_attributes params[:project]
      redirect_to intern_project_path @project
      flash[:success] = 'Deine Änderungen wurden erfolgreich gespeichert'
    else
      render :edit
    end
  end

end
