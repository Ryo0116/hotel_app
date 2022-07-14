class ReservationsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @room = Room.find(params[:room_id])
  
          start_date = Date.parse(reservation_params[:start_date])
          end_date = Date.parse(reservation_params[:end_date])
          days = (end_date - start_date).to_i + 1
  
          @reservation = current_user.reservations.build(reservation_params)
          @reservation.room = room
          @reservation.single_rate = room.single_rate
          @reservation.total = room.single_rate * days
          @reservation.save
  
          flash[:notice] = "予約が完了しました。"
        end
        #redirect_to room
    end

    def your_reservations
      @rooms = current_user.rooms
    end
  
  
    private
      def reservation_params
        params.require(:reservation).permit(:start_date, :end_date)
      end