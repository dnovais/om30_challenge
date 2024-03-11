# frozen_string_literal: true

class MunicipesController < ApplicationController
  def index
    if params[:search].present?
      @municipes = Municipe.filter_by_full_name(params[:search])
    else
      @municipes = Municipe.all
    end
  end
end
