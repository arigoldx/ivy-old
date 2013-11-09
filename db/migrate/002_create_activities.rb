class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.column :name, :string
      t.column :updated_at, :datetime
      t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :activities
  end
end
