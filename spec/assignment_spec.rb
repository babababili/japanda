require 'spec_helper'

describe 'course assignment' do
  context 'with no hash' do
    let(:canvas_course) { CanvasFactory::Course.new }
    it 'should be created' do
      canvas_course.add_assignment
      expect(canvas_course.assignments[0].course_id).to eql canvas_course.course_id
    end
  end

  context 'with hash merge' do
    let(:canvas_course) { CanvasFactory::Course.new }
    let(:name) { 'Assignment-Calculus I' }
    let(:opts) { { assignment: { name: name, published: true } } }
    it 'should be created' do
      canvas_course.add_assignment opts
      expect(canvas_course.assignments[0].course_id).to eql canvas_course.course_id
      expect(canvas_course.assignments[0].name).to eql name
      expect(canvas_course.assignments[0].published).to be_truthy
    end
  end

  context 'with hash' do
    let(:canvas_course) { CanvasFactory::Course.new }
    let(:name) { 'Assignment-Calculus II' }
    let(:opts) {
      {
        assignment: {
          name: name,
          grading_type: 'gpa_scale',
          submission_types: ['online_text_entry'],
          points_possible: 50,
          due_at: (DateTime.now + 1).iso8601,
          published: true
        }
      }
    }
    it 'should be created' do
      canvas_course.add_assignment opts, false
      expect(canvas_course.assignments[0].course_id).to eql canvas_course.course_id
      expect(canvas_course.assignments[0].name).to eql name
      expect(canvas_course.assignments[0].published).to be_truthy
      expect(canvas_course.assignments[0].grading_type).to eql 'gpa_scale'
    end
  end
end
