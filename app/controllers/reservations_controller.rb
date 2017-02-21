class ReservationsController < ApplicationController
	before_action :authenticate_user!

	def preload
		room = Room.find(params[:room_id])
		today = Date.today
		reservations = room.reservations.where("start_date >= ? OR end_date >= ?", today, today)
		render json: reservations
	end
	
	def preview
		# input에서 가져온 값들($start_date_get,$end_date_get,room.id)
		start_date = Date.parse(params[:start_date])
		end_date = Date.parse(params[:end_date])

		output = {
			conflict: is_conflict(start_date, end_date)
		}

		render json: output
	end

	def create
		@reservation = current_user.reservations.build(reservation_params)
		if @reservation.save
			redirect_to @reservation.room, notice: "성공적으로 예약되었습니다!"	
		else
			redirect_to @reservation.room, alert: "잘못된 날짜 이거나, 날짜를 선택하지 않았습니다."
		end
	end

	def trips
		@trips = current_user.reservations
	end	

	def my_reservations
		@rooms = current_user.rooms
	end
	
	private

	def is_conflict(start_date, end_date)
		room = Room.find(params[:room_id])
		check = room.reservations.where("? < start_date AND end_date < ?",start_date, end_date)
		# 파라미터로 받은 날짜 사이에 예약이 있는지 확인
		check.size > 0 ? true : false
	end

	def reservation_params
		params.require(:reservation).permit(:start_date, :end_date, :price, :total, :room_id)
	end
end