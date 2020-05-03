require 'rails_helper'

RSpec.describe SchedulesController, type: :controller do
  let(:schedule) { create(:schedule) }

  describe 'GET #index' do
    before { get :index }

    it 'returns a success response' do
      expect(response).to be_successful
    end

    it 'assigns the collection of all schedules to @schedules' do
      expect(assigns(:schedules)).to eq Schedule.all
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

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
    context 'with valid params' do
      it 'saves the new schedule to database' do
        expect { post :create, params: { schedule: attributes_for(:schedule) } }
          .to change(Schedule, :count).by 1
      end

      it 'redirects to newly created schedule' do
        post :create, params: { schedule: attributes_for(:schedule) }
        expect(response).to redirect_to assigns(:schedule)
      end
    end

    context 'with invalid params' do
      it 'does not save the new schedule to database' do
        expect { 
          post :create, params: {
            schedule: attributes_for(:schedule, :invalid)
          }
        }.to_not change(Schedule, :count)
      end

      it 're-renders the new template' do
        post :create, params: { schedule: attributes_for(:schedule, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
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

    context 'with invalid params' do
      it 'does not save changes to the database' do
        expect {
          patch :update, params: {
            id: schedule, schedule: attributes_for(:schedule, :invalid)
          }
        }.to_not change { schedule.reload.attributes }

      end

      it 're-renders the edit template' do
        patch :update, params: {
          id: schedule, schedule: attributes_for(:schedule, :invalid)
        }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:schedule) { create(:schedule) }

    it 'assigns the requested schedule to @schedule' do
      delete :destroy, params: { id: schedule }
      expect(assigns(:schedule)).to eq schedule
    end

    it 'deletes the schedule' do
      expect { delete :destroy, params: { id: schedule } }
        .to change(Schedule, :count).by -1
    end

    it 'redirects to index' do
      delete :destroy, params: { id: schedule }
      expect(response).to redirect_to schedules_path
    end
  end
end
