# encoding: utf-8
class Intern::AccountsController < InternController
  def show
    @user = params[:id] ? User.find(params[:id]) : current_intern_user
  end

  def new
    authorize! :new, User
    @user = User.new
  end

  def create
    authorize! :create, User

    if params[:user][:email].blank?
      flash[:error] = "E-Mail muss angegeben werden"
    elsif User.exists? :email => params[:user][:email]
      flash[:error] = "Der Benutzer #{params[:user][:email]} wurde bereits eingeladen"
    else
      @user = User.new params[:user]

      @user.save :validate => false

      flash[:success] = "Der Benutzer #{params[:user][:email]} wurde eingeladen"
    end

    flash.keep
    redirect_to new_intern_account_path
  end

  def edit
    @user = current_intern_user
  end

  def update
    @user = current_intern_user
    if current_intern_user.update_attributes params[:user]
      redirect_to intern_profile_path
      flash[:success] = 'Deine Änderungen wurden erfolgreich gespeichert'
    else
      render :edit
    end
  end
end
