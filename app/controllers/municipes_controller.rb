# frozen_string_literal: true

class MunicipesController < ApplicationController
  before_action :set_municipe, only: %i[edit update]

  def index
    if params[:search].present?
      @municipes = Municipe.filter_by_full_name(params[:search])
    else
      @municipes = Municipe.all
    end
  end

  def new
    @municipe = Municipe.new
    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "municipes_frame",
          partial: "municipes/form",
          locals: { municipe: @municipe }
        )
      end
    end
  end

  def create
    @municipe = Municipe.new(municipe_params)
    if @municipe.save
      redirect_to municipes_path, notice: "Municipe was successfully created."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @municipe.update(municipe_params)
      redirect_to municipes_path, notice: "Municipe was successfully updated."
    else
      render :edit
    end
  end

  private

  def set_municipe
    @municipe = Municipe.find(params[:id])
  end

  def municipe_params
    params.require(:municipe).permit(:full_name, :cpf, :cns, :email, :birth, :phone, :photo, :status)
  end
end
