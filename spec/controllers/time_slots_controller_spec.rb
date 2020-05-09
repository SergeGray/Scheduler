require 'rails_helper'

RSpec.describe TimeSlotsController, type: :controller do
  let!(:schedule) { create(:schedule) }
  let(:time_slot) { create(:time_slot) }

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

  describe 'PATCH #update' do
    it 'saves the changes to the time slot to database' do
      expect do
        patch :update, params: {
          id: time_slot, time_slot: attributes_for(:time_slot, :new)
        }
      end.to change { time_slot.reload.day }.to(
        attributes_for(:time_slot, :new)[:day]
      ).and change { time_slot.reload.start_time.to_s(:time) }.to(
        attributes_for(:time_slot, :new)[:start_time].to_s(:time)
      ).and change { time_slot.reload.end_time.to_s(:time) }.to(
        attributes_for(:time_slot, :new)[:end_time].to_s(:time)
      )
    end

    it 'redirects to the schedule' do
      patch :update, params: {
        id: time_slot, time_slot: attributes_for(:time_slot, :new)
      }
      expect(response).to redirect_to time_slot.schedule
    end
  end

  describe 'DELETE #destroy' do
    let!(:time_slot) { create(:time_slot, schedule: schedule) }

    it 'assigns the requested time slot to @time_slot' do
      delete :destroy, params: { id: time_slot }
      expect(assigns(:time_slot)).to eq time_slot
    end

    it 'deletes the time slot' do
      expect { delete :destroy, params: { id: time_slot } }
        .to change(TimeSlot, :count).by(-1)
    end

    it 'redirects to time slot schedule' do
      delete :destroy, params: { id: time_slot }
      expect(response).to redirect_to schedule_path(time_slot.schedule)
    end
  end
end
