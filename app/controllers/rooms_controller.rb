class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]

  def index
    @rooms = Room.all
    @myrooms = current_user.rooms
  end

  def show
    @photos = @room.photos
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params)
    
    if @room.save
      if params[:images]
        params[:images].each do |image|
          @room.photos.create(image:image)
        end
      end

      @photos = @room.photos
      redirect_to @room, notice: "성공적으로 숙소를 등록했어요!"
    else
      render :new
    end
  end

  def edit
    if current_user.id == @room.user.id
      @photos = @room.photos
    else
      redirect_to root_path, notice: "수정권한이 없습니다!"  
    end
    
  end

  def update
    if @room.update(room_params)

      if @room.save
        if params[:images]
          params[:images].each do |image|
            @room.photos.create(image:image)
          end
        end
      end
      
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
