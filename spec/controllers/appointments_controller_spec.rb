require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do
  let(:time_slot) { create(:time_slot) }
  let(:appointment) { create(:appointment) }

  describe 'POST #create' do
    context 'with valid params' do
      it 'assigns a new appointment to @appointment' do
        patch :update, params: {
          id: appointment,
          appointment: attributes_for(:appointment, :new),
          format: :js
        }
        expect(assigns(:appointment)).to be_an(Appointment)
      end

      it 'creates a new appointment' do
        expect do
          post :create, params: {
            appointment: attributes_for(
              :appointment, time_slot_id: time_slot.id
            ),
            format: :js
          }
        end.to change(Appointment, :count).by 1
      end

      it 'renders the create template' do
        post :create, params: {
          appointment: attributes_for(:appointment, time_slot_id: time_slot.id),
          format: :js
        }
        expect(response).to render_template(:create)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'assigns the requested appointment to @appointment' do
        patch :update, params: {
          id: appointment,
          appointment: attributes_for(:appointment, :new),
          format: :js
        }
        expect(assigns(:appointment)).to eq appointment
      end

      it 'saves the changes to the appointment to database' do
        expect do
          patch :update, params: {
            id: appointment,
            appointment: attributes_for(:appointment, :new),
            format: :js
          }
        end.to change { appointment.reload.title }.to(
          attributes_for(:appointment, :new)[:title]
        ).and change { appointment.description }.to(
          attributes_for(:appointment, :new)[:description]
        )
      end

      it 'renders the update template' do
        patch :update, params: {
          id: appointment,
          appointment: attributes_for(:appointment, :new),
          format: :js
        }
        expect(response).to render_template :update
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:appointment) { create(:appointment) }

    it 'assigns the requested appointment to @appointment' do
      delete :destroy, params: { id: appointment, format: :js }
      expect(assigns(:appointment)).to eq appointment
    end

    it 'deletes the appointment' do
      expect { delete :destroy, params: { id: appointment, format: :js } }
        .to change(Appointment, :count).by(-1)
    end

    it 'renders the destroy template' do
      delete :destroy, params: { id: appointment, format: :js }
      expect(response).to render_template :destroy
    end
  end
end
