class ActivityLog < ActiveRecord::Base
  belongs_to :activity
  belongs_to :lesson
  belongs_to :student
  belongs_to :course
end
