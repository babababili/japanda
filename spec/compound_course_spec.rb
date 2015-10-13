require 'spec_helper'

describe 'compound course' do
  context 'with assignment and quiz items' do
    let(:canvas_course) { CanvasFactory::Course.new }
    it 'should be created' do
      course_module = canvas_course.add_module

      assignment = canvas_course.add_assignment
      quiz = canvas_course.add_quiz

      course_module.add_module_item(assignment)
      course_module.add_module_item(quiz)

      course_module.publish
      expect(canvas_course.modules.size).to eq 1
      expect(canvas_course.modules[0].module_items.size).to eq 2
      expect(canvas_course.modules[0].module_items[0].course_id).to eql canvas_course.course_id
      expect(canvas_course.modules[0].module_items[0].type).to eql 'Assignment'
    end
  end
end
