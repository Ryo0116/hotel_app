class ReservationsController < ApplicationController
    before_action :authenticate_user!

    before_action :permit_params, only: :confirm
    


    def index
      @reservations = current_user.reservations.all
      @reservations = @rooms
    end

    def new
      session.delete(:reservation)
      @reservation = Reservation.new
      @room = Room.find(params[:room_id])
      render 'reservations/confirm'
    end

    def back
      @reservation = Reservation.new(session[:reservation])
      session.delete(:reservation)
      render :new
    end

    def confirm
      @room = Room.find(params[:room_id])
      @reservation = Reservation.new(@attr)
      session[:reservation] = @reservation
      if @reservation.invalid?
        render 'reservations/confirm'
      end
    end

    def complete
      Reservation.create!(session[:reservation])
      session.delete(:reservation)
    end

    def create
      @room = Room.find(params[:room_id])
        @reservation = Reservation.new
        @start_date = Date.parse(reservation_params[:start_date])
        @end_date = Date.parse(reservation_params[:end_date])
        @days = (end_date - start_date).to_i + 1
        @reservation = current_user.reservations.build(reservation_params)
        @reservation.room = @room
        #@reservation.single_rate = room.single_rate
        #@reservation.total = room.single_rate * days * number_of_people
        @reservation.save
  
        flash[:notice] = "予約が完了しました。"
      redirect_to :rooms_posts
    end

    private
      def reservation_params
        params.require(:reservation).permit(:start_date, :end_date, :number_of_people, :room_id, :room_name, :user_id, :room_image_name)
      end

      def permit_params
        @attr = params.permit(:start_date, :end_date, :number_of_people, :room_id, :room_name, :user_id, :room_image_name)
      end
    end