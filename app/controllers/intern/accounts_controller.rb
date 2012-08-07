class Intern::AccountsController < InternController
  def new
    @user = User.new
  end

  def create
    if params[:user][:email].blank?
      flash[:error] = "E-Mail muss angegeben werden"
    elsif User.exists? :email => params[:user][:email]
      flash[:error] = "Der Benutzer #{params[:user][:email]} wurde bereits eingeladen"
    else
      @user = User.create params[:user]

      @user.save :validate => false

      flash[:success] = "Der Benutzer #{params[:user][:email]} wurde eingeladen"
    end

    flash.keep
    redirect_to new_intern_account_path
  end
end
