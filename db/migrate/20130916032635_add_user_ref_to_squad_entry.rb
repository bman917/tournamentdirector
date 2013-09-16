class AddUserRefToSquadEntry < ActiveRecord::Migration
  def change
    add_reference :squad_entries, :user, index: true
  end
end
