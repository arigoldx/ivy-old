class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.column :first_name, :string
      t.column :middle_name, :string
      t.column :last_name, :string
      t.column :nickname, :string
      t.column :gender, :string
      t.column :updated_at, :datetime
      t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :students
  end
end
