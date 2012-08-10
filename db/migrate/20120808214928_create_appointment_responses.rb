class CreateAppointmentResponses < ActiveRecord::Migration
  def change
    create_table :appointment_responses do |t|
      t.references :user
      t.references :appointment
      t.boolean :accepted

      t.timestamps
    end

    add_index :appointment_responses, [:user_id, :appointment_id], :unique => true
  end
end
