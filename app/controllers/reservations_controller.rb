class ReservationsController < ApplicationController
	before_action :authenticate_user!, except: [:notify]

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
			values = {
				business: "project42da-facilitator@naver.com",
				cmd: '_xclick',
				upload: 1,
				notify_url: "#{Rails.application.secrets.app_host}/notify",
				amount: (@reservation.total+40000)/1000,
				item_name: @reservation.room.listing_name,
				item_number: @reservation.id,
				quatity: '1',
				return: "#{Rails.application.secrets.app_host}/trips"
			}

			redirect_to "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
		else
			redirect_to @reservation.room, alert: "잘못된 날짜 이거나, 날짜를 선택하지 않았습니다."
		end
	end

	protect_from_forgery except: [:notify]
	def notify
		params.permit!
		status = params[:payment_status]
		reservation = Reservation.find(params[:item_number])

		if status == "Completed"
      reservation.update_attributes(status: true)
    else
    	reservation.destroy
    end

		render nothing: true
	end

	protect_from_forgery except: [:trips]
	def trips
		@trips = current_user.reservations.where("status = ?", true)
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