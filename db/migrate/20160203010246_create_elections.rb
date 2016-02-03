class CreateElections < ActiveRecord::Migration
  def change
    create_table :elections do |t|
      t.string :state
      t.string :kind
      t.datetime :date
    end
  end
end
