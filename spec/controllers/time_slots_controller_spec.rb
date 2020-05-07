require 'rails_helper'

RSpec.describe TimeSlotsController, type: :controller do
  let!(:schedule) { create(:schedule) }

  describe 'POST #create' do
    it 'assigns requested schedule to @schedule' do
      post :create, params: {
        schedule_id: schedule.id, time_slot: attributes_for(:time_slot)
      }
      expect(assigns(:schedule)).to eq schedule
    end

    it 'creates a new schedule time slot' do
      expect do
        post :create, params: {
          schedule_id: schedule.id, time_slot: attributes_for(:time_slot)
        }
      end.to change(schedule.time_slots, :count).by 1
    end

    it 'redirects to the schedule' do
      post :create, params: {
        schedule_id: schedule.id, time_slot: attributes_for(:time_slot)
      }
      expect(response).to redirect_to schedule
    end
  end
end
