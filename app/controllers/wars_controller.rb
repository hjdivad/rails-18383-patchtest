class WarsController < ApplicationController
  def index
    @wars = War.m2mtest
  end
end
