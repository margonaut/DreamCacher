class DreamsController < ApplicationController
  def new
    @dream = Dream.new
  end
end
