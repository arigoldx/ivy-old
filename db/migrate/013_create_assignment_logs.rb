class CreateAssignmentLogs < ActiveRecord::Migration
  def self.up
    create_table :assignment_logs do |t|
      t.column :assignment_id, :integer
      t.column :course_id, :integer
      t.column :student_id, :integer
      t.column :grade, 'int(1) unsigned'
      t.column :due_date, :datetime
      t.column :submitted_date, :datetime
      t.column :updated_at, :datetime
      t.column :created_at, :datetime
    end

      add_index :assignment_logs, [:student_id, :assignment_id]
      add_index :assignment_logs, :assignment_id
  end

  def self.down
    drop_table :assignment_logs
  end
end
