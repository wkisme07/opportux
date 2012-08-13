class Admins::AdvertisesController < Admins::ApplicationController
  before_filter :find_adv, :only => [:show, :edit, :update, :destroy]

  # all adv
  def index
    @advs = Advertise.order("size ASC, created_at DESC, viewed DESC").paginate(:page => params[:page])
  end

  def new
    @adv = Advertise.new
  end

  def create
    @adv = Advertise.new(params[:advertise])
    if @adv.save
      flash[:notice] = "Advertise is created"
      redirect_to admins_advertise_path(@adv)
    else
      flash[:alert] = @adv.errors.try(:full_messages).try(:join, '<br />')
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @adv.update_attributes(params[:advertise])
      flash[:notice] = "Advertise updated."
      redirect_to admins_advertises_path
    else
      flash[:alert] = @adv.errors.try(:full_messages).try(:join, '<br />')
      render :edit
    end
  end

  def destroy
    if @adv && @adv.destroy
      flash[:notice] = "Advertise removed."
    else
      flash[:alert] = "Failed to remove advertise."
    end

    redirect_to admins_advertises_path
  end

  protected

    def find_adv
      @adv = Advertise.find_by_id(params[:id])
    end
end
