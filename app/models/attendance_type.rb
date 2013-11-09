class AttendanceType < ActiveRecord::Base
  has_many :attendance, :dependent => :destroy
  
  def self.find_all_mapped_for_select_list
    find(:all, :order => "name").map { |s| [ s.name, s.id ] }
  end
end
