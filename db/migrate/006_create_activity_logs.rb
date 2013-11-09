class CreateActivityLogs < ActiveRecord::Migration
  def self.up
    create_table :activity_logs do |t|
      t.column :activity_id, :integer
      t.column :student_id, :integer
      t.column :lesson_id, :integer
      t.column :course_id, :integer
      t.column :date, :date
      t.column :updated_at, :datetime
      t.column :created_at, :datetime
    end

    add_index :activity_logs, [:student_id, :activity_id]
    add_index :activity_logs, :activity_id
  end

  def self.down
    drop_table :activity_logs
  end
end
