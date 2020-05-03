require 'rails_helper'

RSpec.describe SchedulesController, type: :controller do
  let(:schedule) { create(:schedule) }

  describe 'GET #new' do
    before { get :new }

    it 'returns a success response' do
      expect(response).to be_successful
    end

    it 'assigns a new schedule to @schedule' do
      expect(assigns(:schedule)).to be_a_new Schedule
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: schedule } }

    it 'assigns the requested schedule to @schedule' do
      expect(assigns(:schedule)).to eq schedule
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: schedule } }

    it 'assigns the requested schedule to @schedule' do
      expect(assigns(:schedule)).to eq schedule
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    it 'saves a new schedule to database' do
      expect { post :create, params: { schedule: attributes_for(:schedule) } }
        .to change(Schedule, :count).by 1
    end

    it 'redirects to newly created schedule' do
      post :create, params: { schedule: attributes_for(:schedule) }
      expect(response).to redirect_to assigns(:schedule)
    end
  end

  describe 'PATCH #update' do
    it 'saves the changes to the schedule to database' do
      expect {
        patch :update, params: {
          id: schedule, schedule: attributes_for(:schedule, :new)
        }
      }.to change { schedule.reload.title }
        .to(attributes_for(:schedule, :new)[:title])
        .and change(schedule, :description)
        .to(attributes_for(:schedule, :new)[:description])
    end

    it 'redirects to the schedule' do
      patch :update, params: {
        id: schedule, schedule: attributes_for(:schedule, :new)
      }
      expect(response).to redirect_to assigns(:schedule)
    end
  end
end
