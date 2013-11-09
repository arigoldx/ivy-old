class Activity < ActiveRecord::Base
  has_many :activity_logs
  has_many :students, :through => :activity_logs
  has_many :lessons, :through => :activity_logs

  def self.mapped_by_name
    find(:all, :order => "name").map { |a| [ a.name, a.id ] }
  end
end
