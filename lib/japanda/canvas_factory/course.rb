module CanvasFactory
  # canvas course class
  class Course
    attr_reader :course_response, :course_id, :course_code, :course_name, :course_request,
                :sections, :modules, :assignments, :quizzes

    def initialize(opts = {}, merge = true)
      @sections = []
      @modules = []
      @assignments = []
      @quizzes = []
      course_name_code = "auto#{SecureRandom.hex}"
      @course_request = {
        account_id: CANVAS_ACCOUNT_ID,
        course: {
          name: course_name_code,
          course_code: course_name_code,
          start_at: Time.now,
          end_at: Time.now + (30 * 24 * 60 * 60),
          license: 'public_domain',
          is_public: true,
          is_public_to_auth_users: false,
          public_syllabus: false,
          public_description: 'api created course',
          allow_student_wiki_edits: true,
          allow_wiki_comments: true,
          allow_student_forum_attachments: true,
          open_enrollment: true,
          self_enrollment: false,
          restrict_enrollments_to_course_dates: false,
          term_id: nil,
          # sis_course_id: '', # field is included only when user has permission to view SIS information
          # integration_id: '', # field is included only when user has permission to view SIS information
          hide_final_grades: true,
          apply_assignment_group_weights: false,
          syllabus_body: 'api syllabus',
          grading_standard_id: nil,
          course_format: 'online'
        },
        offer: true,
        enroll_me: false,
        enable_sis_reactivation: false
      }
      @course_request = Mergie.deep_merge(@course_request, opts, merge)
      create_course
    end

    def add_section(opts = {}, merge = true)
      section = CanvasFactory::Section.new(@course_id, opts, merge)
      @sections << section
    end

    def add_module(opts = {}, merge = true)
      mod = CanvasFactory::Module.new(@course_id, opts, merge)
      @modules << mod
      mod
    end

    def add_assignment(opts = {}, merge = true)
      assignment = CanvasFactory::Assignment.new(@course_id, opts, merge)
      @assignments << assignment
      assignment
    end

    def add_quiz(opts = {}, merge = true)
      quiz = CanvasFactory::Quiz.new(@course_id, opts, merge)
      @quizzes << quiz
      quiz
    end

    private

    def create_course
      course_end_point = "#{CANVAS_API_V1}/accounts/#{@course_request[:account_id]}/courses"
      @course_response = CanvasFactory.perform_post(course_end_point, @course_request)
      @course_id = @course_response['id']
      @course_name = @course_response['name']
      @course_code = @course_response['course_code']
      self
    end
  end
end
