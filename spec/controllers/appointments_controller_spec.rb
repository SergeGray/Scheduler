require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do
  let(:user) { create(:user) }
  let(:schedule_owner) { create(:user) }
  let(:appointment_owner) { create(:user) }
  let(:schedule) { create(:schedule, user: schedule_owner) }
  let(:time_slot) { create(:time_slot, schedule: schedule) }
  let(:appointment) do
    create(:appointment, time_slot: time_slot, user: appointment_owner)
  end

  describe 'GET #show' do
    context 'authenticated user' do
      before do
        login(user)
        get :show, params: { id: appointment }
      end

      it 'assigns the requested appointment to @appointment' do
        expect(assigns(:appointment)).to eq appointment
      end

      it 'renders show view' do
        expect(response).to render_template :show
      end
    end

    context 'unauthenticated user' do
      it_behaves_like 'requires authentication' do
        let(:action_call) { get :show, params: { id: appointment } }
      end
    end
  end

  describe 'POST #create' do
    context 'authenticated user' do
      before { login(user) }

      context 'with valid params' do
        it 'assigns a new appointment to @appointment' do
          post :create, params: {
            appointment: attributes_for(
              :appointment, time_slot_id: time_slot.id
            ),
            format: :js
          }
          expect(assigns(:appointment)).to be_an(Appointment)
        end

        it 'creates a new user appointment' do
          expect do
            post :create, params: {
              appointment: attributes_for(
                :appointment, time_slot_id: time_slot.id
              ),
              format: :js
            }
          end.to change(user.appointments, :count).by 1
        end

        it 'renders the create template' do
          post :create, params: {
            appointment: attributes_for(
              :appointment, time_slot_id: time_slot.id
            ),
            format: :js
          }
          expect(response).to render_template(:create)
        end
      end
    end

    context 'unauthenticated user' do
      it 'does not create a new appointment' do
        expect do
          post :create, params: {
            appointment: attributes_for(
              :appointment, time_slot_id: time_slot.id
            ),
            format: :js
          }
        end.to_not change(Appointment, :count)
      end

      it_behaves_like 'unauthorized action' do
        let(:action_call) do
          post :create, params: {
            appointment: attributes_for(
              :appointment, time_slot_id: time_slot.id
            ),
            format: :js
          }
        end
      end
    end
  end

  describe 'PATCH #update' do
    context 'Schedule owner' do
      before { login(schedule_owner) }

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

    context 'Appointment owner' do
      before { login(appointment_owner) }

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

    context 'Authenticated user' do
      before { login(user) }

      it "doesn't do any changes to the appointment" do
        expect do
          patch :update, params: {
            id: appointment,
            appointment: attributes_for(:appointment, :new),
            format: :js
          }
        end.to_not change { appointment.reload.attributes }
      end

      it 'redirects to root' do
        patch :update, params: {
          id: appointment,
          appointment: attributes_for(:appointment, :new),
          format: :js
        }
        expect(response).to redirect_to root_path
      end
    end

    context 'Unauthenticated user' do
      it "doesn't do any changes to the appointment" do
        expect do
          patch :update, params: {
            id: appointment,
            appointment: attributes_for(:appointment, :new),
            format: :js
          }
        end.to_not change { appointment.reload.attributes }
      end

      it_behaves_like 'unauthorized action' do
        let(:action_call) do
          patch :update, params: {
            id: appointment,
            appointment: attributes_for(:appointment, :new),
            format: :js
          }
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:appointment) { create(:appointment) }

    context 'authenticated user' do
      before { login(user) }

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

    context 'unauthenticated user' do
      it 'does not delete the appointment' do
        expect { delete :destroy, params: { id: appointment, format: :js } }
          .to_not change(Appointment, :count)
      end

      it_behaves_like 'unauthorized action' do
        let(:action_call) do
          delete :destroy, params: { id: appointment, format: :js }
        end
      end
    end
  end
end
