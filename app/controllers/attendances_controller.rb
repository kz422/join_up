class AttendancesController < ApplicationController
  def create
    @meeting = Meeting.find(params[:meeting_id])
    # Deviseが提供するcurrent_userが使える
    unless Attendance.exists?(meeting: @meeting, user: current_user)
      Attendance.create!(meeting: @meeting, user: current_user, checkin_time: Time.current)
    end

    respond_to do |format|
      format.json { render json: { status: "ok" } }
      format.html { redirect_to meeting_path(@meeting), notice: "Attended!" }
    end
  end

  def destroy
    @meeting = Meeting.find(params[:meeting_id])
    @user = User.find(1) # 例：固定
    attendance = Attendance.find_by(user: @user, meeting: @meeting)
    attendance&.update(checkout_time: Time.current)

    redirect_to @meeting
  end
end
