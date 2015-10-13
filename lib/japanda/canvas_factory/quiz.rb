module CanvasFactory
  # Quiz class
  class Quiz
    attr_reader :id, :course_id, :html_url, :published, :due_at, :title,
                :request, :response

    def initialize(course_id, opts = {}, merge = true)
      @course_id = course_id
      @request = {
        quiz: {
          title: "quiz-#{Time.now.to_i}",
          description: 'api created quiz',
          quiz_type: %w(practice_quiz assignment graded_survey survey).sample,
          assignment_group_id: nil,
          time_limit: nil,
          shuffle_answers: true,
          hide_results: %w(always until_after_last_attempt).sample,
          show_correct_answers: true,
          show_correct_answers_last_attempt: true,
          hide_correct_answers_at: true,
          allowed_attempts: 1,
          scoring_policy: %w(keep_highest keep_latest).sample,
          one_question_at_a_time: false,
          cant_go_back: false,
          access_code: nil,
          ip_filter: nil,
          due_at: (DateTime.now + 10).iso8601,
          lock_at: (DateTime.now + 10).iso8601,
          unlock_at: (DateTime.now).iso8601,
          published: true,
          one_time_results: false
        }
      }
      @request = Mergie.deep_merge(@request, opts, merge)
      create_quiz
      self
    end

    private

    def create_quiz
      quiz_end_point = "#{CANVAS_API_V1}/courses/#{@course_id}/quizzes"
      @response = CanvasFactory.perform_post(quiz_end_point, @request)
      @id = response['id']
      @title = response['title']
      @html_url = response['html_url']
      @published = response['published']
      @due_at = response['due_at']
    end
  end
end

