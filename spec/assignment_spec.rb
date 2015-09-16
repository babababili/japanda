require 'spec_helper'

describe 'assignment' do
  context 'with no config' do
    let(:canvas_course) { CanvasFactory::Course.new }
    it 'should be created' do
      course_module = CanvasFactory::Module.new(canvas_course.course_id)
      assignment = course_module.add_assignment
      expect(assignment.course_id).to eql canvas_course.course_id
      expect(assignment.published).to be true
      expect(assignment.created_at).to include Time.now.to_date.to_s
    end

    it 'should be created with many assignments' do
      module_with_assignments = CanvasFactory::Module.new(canvas_course.course_id)
      random_number = rand(2..10)
      random_number.times { module_with_assignments.add_assignment }
      expect(module_with_assignments.assignments.size) == random_number
    end

    it 'should be created with no assignment' do
      module_with_assignments = CanvasFactory::Module.new(canvas_course.course_id)
      0.times { module_with_assignments.add_assignment }
      expect(module_with_assignments.assignments.size) == 0
    end
  end

  context 'with config' do
    let(:canvas_course) { CanvasFactory::Course.new }
    let(:assignment_name) { 'Maths puzzles' }
    let(:assignment_g_scale) { 'gpa_scale' }
    let(:course_module) { CanvasFactory::Module.new(canvas_course.course_id) }
    it 'should be created' do
      assignment_config = CanvasFactory::AssignmentConfig.new(grading_type: assignment_g_scale)
      assignment_config.name = assignment_name
      assignment = course_module.add_assignment('MyModuleAssignmentName', assignment_config)
      expect(assignment.name).to eql assignment_name
      expect(assignment.grading_type).to eql assignment_g_scale
      expect(assignment.course_id).to eql canvas_course.course_id
      expect(assignment.published).to be true
    end
  end
end
