class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.column :name, :string
      t.column :description, :text
      t.column :grading_type, 'int(1) unsigned'
      t.column :min_grade, 'int(1) unsigned'
      t.column :max_grade, 'int(1) unsigned'
      t.column :updated_at, :datetime
      t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :assignments
  end
end
