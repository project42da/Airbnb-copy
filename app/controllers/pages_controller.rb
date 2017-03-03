class PagesController < ApplicationController
  def index
    @rooms = Room.all
    @cities = %W(la london miami paris 서울 tokyo capetown detroit firenze habana)
  end

  def search
    if params[:search].present? && params[:search].strip != ""

      # search검색어는 list_name과 kor_address(한국주소)에서만 확인한다. === near로 거리측정을 못한다ㅎ..
      # model에서 지정한 word_Start와 word_middle을 match의 값으로 입력.
      @rooms = Room.search(
        params[:search],
        operator: "or", 
        fields: [:listing_name, :kor_address],
        match: :word_start,
        match: :word_middle
      )

    else
      @rooms = Room.all
    end

    #params[:search]만으로 searchkick이 서치한 결과를 가지고 가능한 날짜를 확인한다.

    if (params[:start_date] && params[:end_date] && !params[:start_date].empty? && !params[:end_date].empty?)
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      
      @rooms = @rooms.to_a #reservation을 체크한뒤 delete를 하기위해 array로 변환한다.

      @rooms.each do |room|
        not_available = room.reservations.where(
          "(? <= start_date AND end_date <= ?)
          OR (? <= end_date AND start_date <= ?)
          OR (start_date < ? AND ? < end_date)",
          start_date, end_date,
          start_date, end_date,
          start_date, end_date
        ).limit(1)

        #@rooms array에서 해당날짜에 예약불가능한 room을 삭제한다.
        if not_available.length > 0
          @rooms.delete(room)
        end

      end
    end
    
    flash[:notice] = "#{@rooms.length}개의 숙소를 찾았습니다."
  end #search


end
