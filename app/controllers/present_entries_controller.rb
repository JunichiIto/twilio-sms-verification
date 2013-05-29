class PresentEntriesController < ApplicationController
  # GET /present_entries
  # GET /present_entries.json
  def index
    @present_entries = PresentEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @present_entries }
    end
  end

  # GET /present_entries/1
  # GET /present_entries/1.json
  def show
    @present_entry = PresentEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @present_entry }
    end
  end

  # GET /present_entries/new
  # GET /present_entries/new.json
  def new
    @present_entry = PresentEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @present_entry }
    end
  end

  # GET /present_entries/1/edit
  def edit
    @present_entry = PresentEntry.find(params[:id])
  end

  # POST /present_entries
  # POST /present_entries.json
  def create
    @present_entry = PresentEntry.new(params[:present_entry])

    respond_to do |format|
      if @present_entry.save
        format.html { redirect_to @present_entry, notice: 'Present entry was successfully created.' }
        format.json { render json: @present_entry, status: :created, location: @present_entry }
      else
        format.html { render action: "new" }
        format.json { render json: @present_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /present_entries/1
  # PUT /present_entries/1.json
  def update
    @present_entry = PresentEntry.find(params[:id])

    respond_to do |format|
      if @present_entry.update_attributes(params[:present_entry])
        format.html { redirect_to @present_entry, notice: 'Present entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @present_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /present_entries/1
  # DELETE /present_entries/1.json
  def destroy
    @present_entry = PresentEntry.find(params[:id])
    @present_entry.destroy

    respond_to do |format|
      format.html { redirect_to present_entries_url }
      format.json { head :no_content }
    end
  end
end
