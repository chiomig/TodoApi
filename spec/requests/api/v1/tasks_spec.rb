require 'rails_helper'

RSpec.describe "Task Requests", :type => :request do

  describe "tasks API" do
    let(:homework){FactoryBot.create(:homework)}
    let(:email){FactoryBot.create(:email)}
    let(:user_with_tasks){FactoryBot.create(:user_with_tasks)}
    let(:token) { authentication_token(user_with_tasks) }
    let(:headers) { {AUTHORIZATION: "Bearer #{token}"} }

    it 'returns a list of tasks for current user' do
      task = homework
      get v1_tasks_path, headers: headers

      expect(response).to be_success
      expect(json.length).to eq(2)
    end

    it 'returns the requested task' do
      get v1_task_path(homework.id), headers: headers

      expect(response).to be_success

      expect(json['name']).to eq("complete homework")
    end

    it 'creates a new task' do
      user =  FactoryBot.create(:user)
      headers = {AUTHORIZATION: "Bearer #{authentication_token(user)}"}
      task_attributes = FactoryBot.attributes_for(:email, user_id: user.id)

      expect {
        post "/v1/tasks", params: { task: task_attributes }, headers: headers
      }.to change(Task, :count).by(1)

      expect(response.status).to eq(201)
    end

    it 'unauthorized user is given 401' do
      get '/v1/tasks'
      expect(response.status).to eq(401)
    end

    it 'returns a 422 when given invalid data' do
      user =  FactoryBot.create(:user)
      headers = {AUTHORIZATION: "Bearer #{authentication_token(user)}"}
      invalid_task = FactoryBot.attributes_for(:invalid_task)

      expect {
        post "/v1/tasks", params: { task: invalid_task }, headers: headers
      }.to_not change(Task, :count)

      expect(response.status).to eq(422)
    end

    it 'deletes task' do
      user =  FactoryBot.create(:user)
      headers = {AUTHORIZATION: "Bearer #{authentication_token(user)}"}
      task = homework
      expect{
        delete "/v1/tasks/#{task.id}", headers: headers
      }.to change(Task, :count).by(-1)
    end

  end
end
