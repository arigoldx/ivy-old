class Attendance < ActiveRecord::Base
  belongs_to :attendance_type
  belongs_to :lesson
  belongs_to :course
  belongs_to :student
end
