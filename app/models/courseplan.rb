class Courseplan < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :course
  acts_as_textiled :text
end
