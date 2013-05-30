class PresentEntriesController < ApplicationController
  before_filter :load_not_verified_entry, only: %w(verification_code_input verification)

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
        format.html { redirect_to present_entry_verification_code_input_path(@present_entry) }
      else
        format.html { render action: "new" }
      end
    end
  end

  def verification_code_input
    respond_to do |format|
      format.html
    end
  end

  def verification
    respond_to do |format|
      if @present_entry.verify_and_save(params[:present_entry])
        format.html { redirect_to @present_entry, notice: I18n.t('notice.create', name: @present_entry.class.model_name.human)}
      else
        format.html { render action: "verification_code_input" }
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

  private

  def load_not_verified_entry
    @present_entry = PresentEntry.not_verified.find(params[:present_entry_id])
  end
end
