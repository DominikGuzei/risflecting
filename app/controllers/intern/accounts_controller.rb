class Intern::AccountsController < InternController
  def show
    authorize! :show, User
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
      @user = User.create params[:user]
      @user.roles << Role.find_by_name('Member')

      @user.save :validate => false

      flash[:success] = "Der Benutzer #{params[:user][:email]} wurde eingeladen"
    end

    flash.keep
    redirect_to new_intern_account_path
  end
end
