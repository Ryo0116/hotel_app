class RoomsController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!, except: [:show]

  def index
    @rooms = current_user.rooms.all
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to :rooms_posts, notice: "保存しました。"
    else
      flash[:alert] = "問題が発生しました。"
      render :new
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  def update
    new_params = room_params
    new_params = room_params.merge(active: true) if is_ready_room
    if @room.update(new_params)
      flash[:notice] = "保存しました。"
    else
      flash[:alert] = "問題が発生しました。"
    end
    redirect_back(fallback_location: request.referer)
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "部屋を削除しました"
    redirect_to :rooms_posts
  end

  private
    def room_params
      params.require(:room).permit(:id, :name, :introduce, :single_rate, :address, :image_name, :user_id)
    end

  # 予約 開始日のAJAX
  def preload
    today = Date.today
    reservations = @room.reservations.where("start_date >= ? OR end_date >= ?", today, today)
    render json: reservations
  end
  #　予約 終了日のAJAX
  def preview
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    output = {
      conflict: is_conflict(start_date, end_date, @room)
    }
    render json: output
  end


    def is_authorised
      redirect_to root_path, alert: "権限がありません。" unless current_user.id == @room.user_id
    end
    def is_ready_room
      !@room.active && !@room.price.blank? && !@room.listing_name.blank? && !@room.photos.blank? && !@room.address.blank?
    end


  # 予約　プライベートメソッド
    def is_conflict(start_date, end_date, room)
      check = room.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
      check.size > 0? true : false
    end

  end