class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:show]

  def index
    @rooms = Room.all
    @myrooms = current_user.rooms
  end

  def show
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room
      @room.save
      redirect_to @room, notice: "성공적으로 숙소를 등록했어요!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      @room.save
      redirect_to @room, notice: "성공적으로 숙소 정보를 수정했어요!"
    else
      render :edit
    end
  end

  def destroy
  end

  private
  def set_room
    @room = Room.find(params[:id])  
  end

  def room_params
    params.require(:room).permit(
      :home_type,
      :room_type,
      :accommodate,
      :bed_room,
      :bath_room,
      :listing_name,
      :summary,
      :address,
      :is_tv,
      :is_kitchen,
      :is_air,
      :is_heating,
      :is_wifi,
      :price,
      :active,
      :check_in,
      :check_out
    )
  end

end
