require 'spec_helper'

describe 'course quiz' do
  context 'with no hash' do
    let(:canvas_course) { CanvasFactory::Course.new }
    it 'should be created' do
      canvas_course.add_quiz
      expect(canvas_course.quizzes.size).to eq 1
      expect(canvas_course.quizzes[0].course_id).to eql canvas_course.course_id
    end
  end

  context 'with hash merge' do
    let(:canvas_course) { CanvasFactory::Course.new }
    let(:title) { 'quiz-Calculus I' }
    let(:opts) { { quiz: { title: title, published: true } } }
    it 'should be created' do
      canvas_course.add_quiz opts
      expect(canvas_course.quizzes.size).to eq 1
      expect(canvas_course.quizzes[0].course_id).to eql canvas_course.course_id
      expect(canvas_course.quizzes[0].title).to eql title
      expect(canvas_course.quizzes[0].published).to eql true
    end
  end

  context 'with hash' do
    let(:canvas_course) { CanvasFactory::Course.new }
    let(:title) { 'quiz-Calculus II' }
    let(:opts) {
      {
        quiz: {
          title: title,
          description: 'api created quiz',
          quiz_type: 'graded_survey',
          published: false,
        }
      }
    }
    it 'should be created' do
      canvas_course.add_quiz opts, false
      expect(canvas_course.quizzes.size).to eq 1
      expect(canvas_course.quizzes[0].course_id).to eql canvas_course.course_id
      expect(canvas_course.quizzes[0].title).to eql title
      expect(canvas_course.quizzes[0].published).to eql false
    end
  end
end