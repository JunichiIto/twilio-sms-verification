class PresentEntriesController < ApplicationController
  def index
    @present_entries = PresentEntry.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @present_entry = PresentEntry.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @present_entry = PresentEntry.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @present_entry = PresentEntry.find(params[:id])
  end

  def create
    @present_entry = PresentEntry.new(params[:present_entry])

    respond_to do |format|
      if @present_entry.save
        format.html { redirect_to @present_entry, notice: I18n.t('notice.create', name: @present_entry.class.model_name.human)}
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @present_entry = PresentEntry.find(params[:id])

    respond_to do |format|
      if @present_entry.update_attributes(params[:present_entry])
        format.html { redirect_to @present_entry, notice: I18n.t('notice.update', name: @present_entry.class.model_name.human)}
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @present_entry = PresentEntry.find(params[:id])
    @present_entry.destroy

    respond_to do |format|
      format.html { redirect_to present_entries_url, notice: I18n.t('notice.destroy', name: @present_entry.class.model_name.human) }
    end
  end
end
