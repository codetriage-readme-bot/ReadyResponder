class RepairsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @repairs = Repair.all
  end

  def show
    @last_editor = last_editor(@repair)
    @page_title = "Repair for #{@repair.item}"
  end

  def new
    @repair = Repair.new
    @repair.item_id = params[:item_id].presence
  end

  def edit
  end

  def create
    @repair = Repair.new(params[:repair])

    if @repair.save
      redirect_to @repair, notice: 'Repair was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    respond_to do |format|
      if @repair.update_attributes(params[:repair])
        redirect_to @repair.item, notice: 'Repair was successfully updated.'
      else
        render action: "edit"
      end
    end
  end

  def destroy
    @repair.destroy
  end
end
