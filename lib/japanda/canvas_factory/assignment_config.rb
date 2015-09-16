module CanvasFactory
  class AssignmentConfig
    attr_accessor :name, :grading_type, :submission_types, :points_possible, :due_at, :published

    def initialize(opts = {})
      @name = opts[:name] || "Assignment-#{Time.now.to_i}"
      @grading_type = opts[:grading_type] || %w(pass_fail percent letter_grade gpa_scale points).sample
      @submission_types = opts[:submission_types] || ['online_text_entry']
      @points_possible = opts[:points_possible] || 10
      @due_at = opts[:due_at] || (DateTime.now + 1).iso8601
      @published = opts[:published] || true
    end

    def request_body
      {
        assignment: {
          name: @name,
          grading_type: @grading_type,
          submission_types: @submission_types,
          points_possible: @points_possible,
          due_at: @due_at,
          published: @published
        }
      }
    end
  end
end