class PagesController < ApplicationController
  def index
    @rooms = Room.all
  end

  def search
    if params[:search].present? && params[:search].strip != ""
      @rooms = Room.search(params[:search])
      flash[:notice] = "#{@rooms.length}개의 숙소를 찾았습니다."
    else
      @rooms = Room.all
      flash[:alert] = "검색어를 입력해 주세요!"
    end
  end
end
