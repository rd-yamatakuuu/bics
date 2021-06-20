class Public::FindersController < ApplicationController

  def finder
    @range = params[:range]

    if @range == 'User'
      @users = User.looks(params[:reference], params[:word])
    elsif @range == 'Idea'
      @ideas = Idea.looks(params[:reference], params[:word])
    elsif @range == 'Tag'
      @tags = Tag.looks(params[:reference], params[:word])
    else
      @specialities = Speciality.looks(params[:reference], params[:word])

    end

  end
end
