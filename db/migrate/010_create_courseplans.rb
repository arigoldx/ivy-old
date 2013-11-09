class CreateCourseplans < ActiveRecord::Migration
  def self.up
    create_table :courseplans do |t|
      t.column :lesson_id, :integer
      t.column :course_id, :integer
      t.column :text, :text
      t.column :date, :date
      t.column :updated_at, :datetime
      t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :courseplans
  end
end
