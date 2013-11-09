class CreateLessons < ActiveRecord::Migration
  def self.up
    create_table :lessons do |t|
      t.column :course_id, :integer, :null => false
      t.column :date, :date
      t.column :start_time, :time
      t.column :end_time, :time
      t.column :room, :integer
      t.column :updated_at, :datetime
      t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :lessons
  end
end
