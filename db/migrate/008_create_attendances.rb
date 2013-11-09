class CreateAttendances < ActiveRecord::Migration
  def self.up
    create_table :attendances do |t|
      t.column :attendance_type_id, :integer
      t.column :lesson_id, :integer
      t.column :course_id, :integer
      t.column :student_id, :integer
      t.column :date, :date
      t.column :updated_at, :datetime
      t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :attendances
  end
end
