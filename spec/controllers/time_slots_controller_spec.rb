require 'rails_helper'

RSpec.describe TimeSlotsController, type: :controller do
  let!(:schedule) { create(:schedule) }
  let(:time_slot) { create(:time_slot, schedule: schedule) }

  describe 'POST #create' do
    context 'with valid params' do
      it 'assigns requested schedule to @schedule' do
        post :create, params: {
          schedule_id: schedule.id,
          time_slot: attributes_for(:time_slot),
          format: :js
        }
        expect(assigns(:schedule)).to eq schedule
      end

      it 'creates a new schedule time slot' do
        expect do
          post :create, params: {
            schedule_id: schedule.id,
            time_slot: attributes_for(:time_slot),
            format: :js
          }
        end.to change(schedule.time_slots, :count).by 1
      end

      it 'renders the create template' do
        post :create, params: {
          schedule_id: schedule.id,
          time_slot: attributes_for(:time_slot),
          format: :js
        }
        expect(response).to render_template :create
      end
    end

    context 'with invalid params' do
      it 'does not save the new time slot to database' do
        expect do
          post :create, params: {
            schedule_id: schedule.id,
            time_slot: attributes_for(:time_slot, :invalid),
            format: :js
          }
        end.to_not change(TimeSlot, :count)
      end

      it 'renders the create template' do
        post :create, params: {
          schedule_id: schedule.id,
          time_slot: attributes_for(:time_slot, :invalid),
          format: :js
        }
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'saves the changes to the time slot to database' do
        expect do
          patch :update, params: {
            id: time_slot,
            time_slot: attributes_for(:time_slot, :new),
            format: :js
          }
        end.to change { time_slot.reload.day }.to(
          attributes_for(:time_slot, :new)[:day]
        ).and change { time_slot.reload.start_time.to_s(:time) }.to(
          attributes_for(:time_slot, :new)[:start_time].to_s(:time)
        ).and change { time_slot.reload.end_time.to_s(:time) }.to(
          attributes_for(:time_slot, :new)[:end_time].to_s(:time)
        )
      end

      it 'renders the update template' do
        patch :update, params: {
          id: time_slot,
          time_slot: attributes_for(:time_slot, :new),
          format: :js
        }
        expect(response).to render_template :update
      end
    end

    context 'with invalid params' do
      it 'does not save changes to the database' do
        expect do
          patch :update, params: {
            id: time_slot,
            time_slot: attributes_for(:time_slot, :invalid),
            format: :js
          }
        end.to_not change { time_slot.reload.attributes }
      end

      it 'renders the update template' do
        patch :update, params: {
          id: time_slot,
          time_slot: attributes_for(:time_slot, :invalid),
          format: :js
        }
        expect(response).to render_template :update
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:time_slot) { create(:time_slot, schedule: schedule) }

    it 'assigns the requested time slot to @time_slot' do
      delete :destroy, params: { id: time_slot, format: :js }
      expect(assigns(:time_slot)).to eq time_slot
    end

    it 'deletes the time slot' do
      expect { delete :destroy, params: { id: time_slot, format: :js } }
        .to change(TimeSlot, :count).by(-1)
    end

    it 'renders the destroy template' do
      delete :destroy, params: { id: time_slot, format: :js }
      expect(response).to render_template :destroy
    end
  end
end
