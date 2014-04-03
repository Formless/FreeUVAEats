class FoodeventsController < ApplicationController
  # GET /foodevents
  # GET /foodevents.json
  def index
    @foodevents = Foodevent.search(params[:search])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @foodevents }
    end
  end

  # GET /foodevents/1
  # GET /foodevents/1.json
  def show
    @foodevent = Foodevent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @foodevent }
    end
  end

  # GET /foodevents/new
  # GET /foodevents/new.json
  def new
    @foodevent = Foodevent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @foodevent }
    end
  end

  # GET /foodevents/1/edit
  def edit
    @foodevent = Foodevent.find(params[:id])
  end

  # POST /foodevents
  # POST /foodevents.json
  def create
    @foodevent = Foodevent.new(params[:foodevent])

    respond_to do |format|
      if @foodevent.save
        format.html { redirect_to @foodevent, notice: 'Foodevent was successfully created.' }
        format.json { render json: @foodevent, status: :created, location: @foodevent }
      else
        format.html { render action: "new" }
        format.json { render json: @foodevent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /foodevents/1
  # PUT /foodevents/1.json
  def update
    @foodevent = Foodevent.find(params[:id])

    respond_to do |format|
      if @foodevent.update_attributes(params[:foodevent])
        format.html { redirect_to @foodevent, notice: 'Foodevent was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @foodevent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foodevents/1
  # DELETE /foodevents/1.json
  def destroy
    @foodevent = Foodevent.find(params[:id])
    @foodevent.destroy

    respond_to do |format|
      format.html { redirect_to foodevents_url }
      format.json { head :ok }
    end
  end
end
