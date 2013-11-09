class CreateAttendanceTypes < ActiveRecord::Migration
  def self.up
    create_table :attendance_types do |t|
      t.column :name, :string
    end
  end

  def self.down
    drop_table :attendance_types
  end
end
