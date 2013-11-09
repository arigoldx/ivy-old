class Assignment < ActiveRecord::Base
    has_many :assignment_logs

    acts_as_textiled :description

    def grading_type_text
        case self.grading_type
            when 0 then "no grading type"
            when 1 then "complete/incomplete"
            when 2 then "min/max"
        end
    end
end
