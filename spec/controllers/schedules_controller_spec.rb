require 'rails_helper'

RSpec.describe SchedulesController, type: :controller do
  let(:user) { create(:user) }
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
    context 'Authenticated user' do
      before do
        login(user)
        get :new
      end

      it 'returns a success response' do
        expect(response).to be_successful
      end

      it 'assigns a new schedule to @schedule' do
        expect(assigns(:schedule)).to be_a_new Schedule
      end

      it 'assigns a new schedule to be a user schedule' do
        expect(assigns(:schedule).user).to eq user
      end

      it 'renders new view' do
        expect(response).to render_template :new
      end
    end

    context 'Unauthenticated user' do
      it_behaves_like 'requires authentication' do
        let(:action_call) { get :new }
      end
    end
  end

  describe 'GET #show' do
    let!(:time_slots) { create_list(:time_slot, 2) }

    before { get :show, params: { id: schedule } }

    it 'assigns the requested schedule to @schedule' do
      expect(assigns(:schedule)).to eq schedule
    end

    it "assigns schedule's time slots to @time_slots" do
      expect(assigns(:time_slots)).to eq schedule.time_slots
    end

    it 'assigns a new time slot to @time_slot' do
      expect(assigns(:time_slot)).to be_a_new(TimeSlot)
    end

    it 'assigns @time_slot to be a @schedule time_slot' do
      expect(assigns(:time_slot).schedule).to eq schedule
    end

    it 'assigns a new appointment to @appointment' do
      expect(assigns(:appointment)).to be_a_new(Appointment)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit' do
    context 'Authenticated user' do
      before do
        login(user)
        get :edit, params: { id: schedule }
      end

      it 'assigns the requested schedule to @schedule' do
        expect(assigns(:schedule)).to eq schedule
      end

      it 'renders edit view' do
        expect(response).to render_template :edit
      end
    end

    context 'Unauthenticated user' do
      it_behaves_like 'requires authentication' do
        let(:action_call) { get :edit, params: { id: schedule } }
      end
    end
  end

  describe 'POST #create' do
    context 'authenticated user' do
      before { login(user) }

      context 'with valid params' do
        it 'saves the new user schedule to database' do
          expect do
            post :create, params: { schedule: attributes_for(:schedule) }
          end.to change(user.schedules, :count).by 1
        end

        it 'redirects to newly created schedule' do
          post :create, params: { schedule: attributes_for(:schedule) }
          expect(response).to redirect_to assigns(:schedule)
        end
      end

      context 'with invalid params' do
        it 'does not save the new schedule to database' do
          expect do
            post :create, params: {
              schedule: attributes_for(:schedule, :invalid)
            }
          end.to_not change(Schedule, :count)
        end

        it 're-renders the new template' do
          post :create, params: {
            schedule: attributes_for(:schedule, :invalid)
          }
          expect(response).to render_template :new
        end
      end
    end

    context 'unauthenticated user' do
      it 'does not create a new schedule' do
        expect do
          post :create, params: { schedule: attributes_for(:schedule) }
        end.to_not change(Schedule, :count)
      end

      it_behaves_like 'requires authentication' do
        let(:action_call) do
          post :create, params: { schedule: attributes_for(:schedule) }
        end
      end
    end
  end

  describe 'PATCH #update' do
    context 'authenticated user' do
      before { login(user) }

      context 'with valid params' do
        it 'saves the changes to the schedule to database' do
          expect do
            patch :update, params: {
              id: schedule, schedule: attributes_for(:schedule, :new)
            }
          end.to change { schedule.reload.title }
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
          expect do
            patch :update, params: {
              id: schedule, schedule: attributes_for(:schedule, :invalid)
            }
          end.to_not change { schedule.reload.attributes }
        end

        it 're-renders the edit template' do
          patch :update, params: {
            id: schedule, schedule: attributes_for(:schedule, :invalid)
          }
          expect(response).to render_template :edit
        end
      end
    end

    context 'unauthenticated user' do
      it 'does not change the schedule' do
        expect do
          patch :update, params: {
            id: schedule, schedule: attributes_for(:schedule, :new)
          }
        end.to_not change { schedule.reload.attributes }
      end

      it_behaves_like 'requires authentication' do
        let(:action_call) do
          patch :update, params: {
            id: schedule, schedule: attributes_for(:schedule, :new)
          }
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:schedule) { create(:schedule) }

    context 'authenticated user' do
      before { login(user) }

      it 'assigns the requested schedule to @schedule' do
        delete :destroy, params: { id: schedule }
        expect(assigns(:schedule)).to eq schedule
      end

      it 'deletes the schedule' do
        expect { delete :destroy, params: { id: schedule } }
          .to change(Schedule, :count).by(-1)
      end

      it 'redirects to index' do
        delete :destroy, params: { id: schedule }
        expect(response).to redirect_to schedules_path
      end
    end

    context 'unauthenticated user' do
      it 'does not delete the schedule' do
        expect { delete :destroy, params: { id: schedule } }
          .to_not change(Schedule, :count)
      end

      it_behaves_like 'requires authentication' do
        let(:action_call) do
          delete :destroy, params: { id: schedule }
        end
      end
    end
  end
end
