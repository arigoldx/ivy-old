class CreateEnrollments < ActiveRecord::Migration
  def self.up
    create_table :enrollments do |t|
      t.column :course_id, :integer
      t.column :student_id, :integer
      t.column :updated_at, :datetime
      t.column :created_at, :datetime
    end
    
    add_index :enrollments, [:student_id, :course_id]
    add_index :enrollments, :course_id
  end

  def self.down
    drop_table :enrollments
  end
end
