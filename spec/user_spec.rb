require 'spec_helper'

describe 'user' do
  context 'with no config' do
    let!(:canvas_user) { CanvasFactory::User.new }
    it 'should be created as learner' do
      canvas_user.create_learner_user
      expect(canvas_user.user_short_name).to eql 'cat auto'
      expect(canvas_user.user_response_id).to be
      expect(canvas_user.user_response_email_id).to match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
    end

    it 'should be created as an admin' do
      canvas_user.create_admin_user
      expect(canvas_user.user_response_id).to be
      expect(canvas_user.user_response_email_id).to match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
    end
  end

  context 'with config' do
    let!(:user_config) { CanvasFactory::UserConfig.new(short_name: 'baylor learner') }
    let!(:canvas_user) { CanvasFactory::User.new(user_config) }
    let(:learner_name) { 'New Learner' }
    let(:admin_name) { 'Administrator Baylor' }
    it 'should be created as learner' do
      user_config.short_name = 'New Learner'
      canvas_user.create_learner_user
      expect(canvas_user.user_short_name).to eql learner_name
      expect(canvas_user.user_response_id).to be
      expect(canvas_user.user_response_email_id).to match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
    end

    it 'should be created as an admin' do
      user_config.short_name = admin_name
      canvas_user.create_admin_user
      expect(canvas_user.user_short_name).to eql admin_name
      expect(canvas_user.user_response_id).to be
      expect(canvas_user.user_response_email_id).to match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
    end
  end
end
