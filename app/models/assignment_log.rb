class AssignmentLog < ActiveRecord::Base
    belongs_to :assignment
    belongs_to :course
    belongs_to :student

    def due_date_string
        self.due_date.to_s(:short)
    end

    def due_date_string=(string)
        self.due_date = Date.parse(string)
    end

    def name
        self.assignment.name
    end

    def description
        self.assignment.description
    end

    def grading_type
        self.assignment.grading_type
    end

    def min_grade
        self.assignment.min_grade
    end

    def max_grade
        self.assignment.max_grade
    end
end
