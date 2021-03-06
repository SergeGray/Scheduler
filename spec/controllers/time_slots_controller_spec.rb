require 'rails_helper'

RSpec.describe TimeSlotsController, type: :controller do
  let(:user) { create(:user) }
  let(:owner) { create(:user) }
  let!(:schedule) { create(:schedule, user: owner) }
  let(:time_slot) { create(:time_slot, schedule: schedule) }

  describe 'POST #create' do
    context 'schedule owner' do
      before { login(owner) }

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

    context 'authenticated user' do
      before { login(user) }

      it 'does not create a time slot' do
        expect do
          post :create, params: {
            schedule_id: schedule.id,
            time_slot: attributes_for(:time_slot),
            format: :js
          }
        end.to_not change(TimeSlot, :count)
      end

      it 'redirects to root' do
        post :create, params: {
          schedule_id: schedule.id,
          time_slot: attributes_for(:time_slot),
          format: :js
        }
        expect(response).to redirect_to root_path
      end
    end

    context 'unauthenticated user' do
      it 'does not create a time slot' do
        expect do
          post :create, params: {
            schedule_id: schedule.id,
            time_slot: attributes_for(:time_slot),
            format: :js
          }
        end.to_not change(TimeSlot, :count)
      end

      it_behaves_like 'unauthorized action' do
        let(:action_call) do
          post :create, params: {
            schedule_id: schedule.id,
            time_slot: attributes_for(:time_slot),
            format: :js
          }
        end
      end
    end
  end

  describe 'PATCH #update' do
    context 'schedule owner' do
      before { login(owner) }

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
          ).and change { time_slot.start_time.to_s(:time) }.to(
            attributes_for(:time_slot, :new)[:start_time].to_s(:time)
          ).and change { time_slot.end_time.to_s(:time) }.to(
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

    context 'authenticated user' do
      before { login(user) }

      it 'does not change the time slot' do
        expect do
          patch :update, params: {
            id: time_slot,
            time_slot: attributes_for(:time_slot, :new),
            format: :js
          }
        end.to_not change { time_slot.reload.attributes }
      end

      it 'redirects to root' do
        patch :update, params: {
          id: time_slot,
          time_slot: attributes_for(:time_slot, :new),
          format: :js
        }
        expect(response).to redirect_to root_path
      end
    end

    context 'unauthenticated user' do
      it 'does not change the time slot' do
        expect do
          patch :update, params: {
            id: time_slot,
            time_slot: attributes_for(:time_slot, :new),
            format: :js
          }
        end.to_not change { time_slot.reload.attributes }
      end

      it_behaves_like 'unauthorized action' do
        let(:action_call) do
          patch :update, params: {
            id: time_slot,
            time_slot: attributes_for(:time_slot, :new),
            format: :js
          }
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:time_slot) { create(:time_slot, schedule: schedule) }

    context 'schedule owner' do
      before { login(owner) }

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

    context 'authenticated user' do
      before { login(user) }

      it 'does not delete the time slot' do
        expect { delete :destroy, params: { id: time_slot, format: :js } }
          .to_not change(TimeSlot, :count)
      end

      it 'redirects to root' do
        delete :destroy, params: { id: time_slot, format: :js }
        expect(response).to redirect_to root_path
      end
    end

    context 'unauthenticated user' do
      it 'does not delete the time slot' do
        expect { delete :destroy, params: { id: time_slot, format: :js } }
          .to_not change(TimeSlot, :count)
      end

      it_behaves_like 'unauthorized action' do
        let(:action_call) do
          delete :destroy, params: { id: time_slot, format: :js }
        end
      end
    end
  end
end
