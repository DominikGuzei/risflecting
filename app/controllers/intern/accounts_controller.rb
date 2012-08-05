class Intern::AccountsController < InternController
  def new
    @user = User.new
  end

  def create
    if User.exists? :email => params[:user][:email]
      flash[:alert] = 'Dieser Benutzer wurde bereits eingeladen!'
    else
      @user = User.create params[:user]

      @user.save :validate => false

      flash[:notice] = 'Benutzer wurde eingeladen!'
    end

    flash.keep
    redirect_to new_intern_account_path
  end
end
