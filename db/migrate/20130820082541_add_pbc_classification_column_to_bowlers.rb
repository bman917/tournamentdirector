class AddPbcClassificationColumnToBowlers < ActiveRecord::Migration
  def change
  	add_reference :bowlers, :pbc_classification, index: true
  end
end
