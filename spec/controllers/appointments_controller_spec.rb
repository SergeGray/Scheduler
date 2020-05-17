require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do
  let(:time_slot) { create(:time_slot) }

  describe 'POST #create' do
    context 'with valid params' do
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
end
