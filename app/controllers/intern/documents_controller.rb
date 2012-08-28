class Intern::DocumentsController < InternController
  authorize_resource

  def index
    @documents = Document.order(:created_at).reverse_order
  end

  def new
    @document = Document.new
  end

  def create
    @document = current_intern_user.documents.new params[:document]
    if @document.save
      flash[:success] = "Das Dokument '#{@document.title}' wurde erfolgreich gespeichert"
      redirect_to intern_documents_path
    else
      render :new
    end
  end
end
