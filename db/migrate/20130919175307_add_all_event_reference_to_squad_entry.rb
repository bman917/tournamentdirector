class AddAllEventReferenceToSquadEntry < ActiveRecord::Migration
  def change
    add_reference :squad_entries, :all_event, index: true
  end
end
