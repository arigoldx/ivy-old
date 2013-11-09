class Lesson < ActiveRecord::Base
    belongs_to :course
    has_many :activity_logs
    has_many :coursenotes
    has_many :courseplans
    has_many :activities, :through => :activity_logs
    has_many :attendances, :dependent => :destroy

    def completed?
        self.activity_logged? && self.note_taken?
    end

    def activity_logged?
        !self.activities.empty?
    end

    def note_taken?
        !self.coursenotes.empty?
    end

    def date_string
        self.date.to_s(:short)
    end

    def date_string=(string)
        self.date = Date.parse(string)
    end

    def start_time_string
        self.start_time.to_s(:hour_minute_ampm)
    end

    def start_time_string=(string)
        self.start_time = Time.parse(string)
    end

    def end_time_string
        self.end_time.to_s(:hour_minute_ampm)
    end

    def end_time_string=(string)
        self.end_time = Time.parse(string)
    end

    def day
        self.date.strftime("%a")
    end

    def students_by_name
        self.course.students.find(:all, :order => "last_name").map { |s| [ s.last_name + ", " + s.first_name, s.id ] }
    end

    def previous
        # the fact that the following line is duplicated in the function called "next" is bad.  real bad.
        lessons = self.course.lessons.find(:all, :order => "date")
        index = lessons.index(self)
        if (index == 0)
            return nil
        else
            lessons.at(index - 1)
        end
    end

    def next
        # the fact that the following line is duplicated in the function called "previous" is bad.  real bad.
        lessons = self.course.lessons.find(:all, :order => "date")
        index = lessons.index(self)
        if (index + 1) == lessons.length
            return nil
        else
            lessons.at(index + 1)
        end
    end

    def self.todays(date)
        find_all_by_date(date, :order => "start_time")
    end

    def self.tomorrow_of(date)
        find_all_by_date(1.day.since(date.to_time), :order => "start_time")
    end

    def self.yesterday_of(date)
        find_all_by_date(1.day.ago(date.to_time), :order => "start_time")
    end

    def past_courseplans(date, limit)
        self.course.courseplans.find(:all, :limit => limit, :conditions =>  ["date <= ?", date], :order => "date DESC")
    end

    def past_activity_logs(date, days)
        self.course.activity_logs.find(:all, :conditions => ["date <= ? AND date > ?", date, days.day.ago(date.to_time)], :order => "date DESC")
    end

    def find_group
        Lesson.find_by_sql(["select * from lessons where course_id = ? and dayofweek(date) = dayofweek(?) and start_time = ? and end_time = ? and date > now()",
                           self.course_id, self.date, self.start_time, self.end_time]) - [self]
    end
end
