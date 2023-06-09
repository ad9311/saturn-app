class RecoveriesController < ApplicationController
  before_action :set_recovery, only: %i[show destroy edit update submit_report renew submit_renew bookmark unbookmark]
  before_action :recovery_params, only: %i[create]
  before_action :recovery_renew_params, only: %i[submit_renew]
  before_action :set_current_date, only: %i[show submit_report favorites]
  before_action :recovery_update_params, only: %i[update]

  include Awards
  include RecoveryHelper

  def index
    @recoveries = current_user.recoveries.order(created_at: :desc)
    @bookmarked_recoveries_count = current_user.recoveries.where(bookmarked: true).count
  end

  def show; end

  def new
    @recovery = Recovery.new
  end

  def edit; end

  def create
    @recovery = current_user.recoveries.build(recovery_params)
    if @recovery.save
      redirect_to recovery_path(@recovery)
    else
      render :new
    end
  end

  def submit_report
    redirect_to recovery_path(@recovery) and return unless allow_submit_recovery_report?(@recovery)

    update_report
    redirect_to recovery_path(@recovery)
  end

  def renew
    redirect_to recovery_path(@recovery) and return unless @recovery.completed?
  end

  def submit_renew
    redirect_to recovery_path(@recovery) and return unless @recovery.completed?

    @recovery.update(**recovery_renew_params, current_record: 0, completed: false)
    redirect_to recovery_path(@recovery)
  end

  def update
    if @recovery.update(recovery_update_params)
      redirect_to recovery_path(@recovery)
    else
      render :edit
    end
  end

  def destroy
    if @recovery.destroy
      redirect_to recoveries_path
    else
      redirect_to recovery_path(@recovery)
    end
  end

  def bookmark
    @recovery.update(bookmarked: true)

    redirect_to recovery_path(@recovery)
  end

  def unbookmark
    @recovery.update(bookmarked: false)
    redirect_to recovery_path(@recovery)
  end

  def favorites
    @recoveries = current_user.recoveries.where(bookmarked: true).order(created_at: :desc)
  end

  def destroy_all
    current_user.recoveries.destroy_all
    redirect_to users_account_path
  end

  private

  def update_report
    max_record = @recovery.max_record
    current_record_plus = @recovery.current_record + 1
    completed = current_record_plus == @recovery.target_days
    @recovery.update(
      report_dates: @recovery.report_dates.push(Time.zone.now),
      max_record: [current_record_plus, max_record].max,
      current_record: current_record_plus,
      completed:
    )

    return unless completed

    tier = calculate_tier(@recovery.target_days)
    Award.create(
      user: current_user,
      title: "Completed recovery: #{@recovery.title}",
      awardable: @recovery,
      tier:
    )
  end

  def recovery_params
    params.require(:recovery).permit(:title, :description, :start_date, :target_date)
  end

  def recovery_update_params
    params.require(:recovery).permit(:title, :description)
  end

  def set_recovery
    @recovery = Recovery.find(params[:id])
  end

  def recovery_renew_params
    params.require(:recovery).permit(:start_date, :target_date)
  end

  def set_current_date
    @current_date = Time.zone.now.to_date
  end
end
