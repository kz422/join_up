class MeetingsController < ApplicationController
  before_action :set_meeting, only: %i[ show edit update destroy ]

  # GET /meetings or /meetings.json
  def index
    @meetings = Meeting.all
    respond_to do |format|
      format.html
      format.json {
        # FullCalendar で受け取る `title, start, end` などに加え、独自情報を "extendedProps" として返す
        render json: @meetings.map { |m|
          {
            id: m.id,                          # イベントID
            title: m.title,                    # カレンダー上のタイトル
            start: m.start_time,              # 開始日時
            end: m.end_time,                  # 終了日時
            extendedProps: {
              location: m.location
              # ほかに表示したい詳細情報や出席情報など
              # 例: isAttending: current_user&.attending?(m) など
            }
          }
        }
      }
    end
  end

  # GET /meetings/1 or /meetings/1.json
  def show
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings or /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: "Meeting was successfully created." }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1 or /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: "Meeting was successfully updated." }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1 or /meetings/1.json
  def destroy
    @meeting.destroy!

    respond_to do |format|
      format.html { redirect_to meetings_path, status: :see_other, notice: "Meeting was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def meeting_params
      params.expect(meeting: [ :title, :location, :start_time, :end_time ])
    end
end
