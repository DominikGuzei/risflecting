class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :title
      t.text :description
      t.timestamp :starttime
      t.timestamp :endtime

      t.timestamps
    end
  end
end
