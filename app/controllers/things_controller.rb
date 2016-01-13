class ThingsController < ApplicationController
  include Trailblazer::Operation::Controller

  def index
  end

  def show
  end

  def new
    form Thing::Create
  end

  def edit
    form Thing::Update
    render action: :new
  end

  def create
    run Thing::Create do |op|
      return redirect_to op.model
    end

    render action: :new
  end

  def update
    run Thing::Update do |op|
      return redirect_to op.model
    end

    render action: :new
  end

end
