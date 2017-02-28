class AddStatusToReservation < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :status, :boolean
  end
end
