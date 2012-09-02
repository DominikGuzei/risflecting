class Intern::DashboardsController < InternController
  def show
    @appointments = Appointment.future.limit 5
    @questions = Question.order(:updated_at).where('updated_at > ?', 14.days.ago).reverse_order.limit 5
    @projects = Project.order(:updated_at).where('updated_at > ?', 14.days.ago).reverse_order.limit 5
    @documents = Document.order(:updated_at).where('updated_at > ?', 14.days.ago).reverse_order.limit 5
  end
end
