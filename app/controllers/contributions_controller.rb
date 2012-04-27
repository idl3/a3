class ContributionsController < ApplicationController
  def index

  end

  def createbiz

  end

  def business
    @contribution = Contribution.new
    @contribution.type = "Business"
  end
end
