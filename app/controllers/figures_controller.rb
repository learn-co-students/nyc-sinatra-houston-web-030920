class FiguresController < ApplicationController
  # gets list of all figures
  get ('/figures') do
    @figures = Figure.all
    erb :"figures/index"
  end

  # create new figure methods
  get ('/figures/new') do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"figures/new"
  end

  post ('/figures') do
    @figure = Figure.create({
      name: params[:figure][:name],
      title_ids: params[:figure][:title_ids],
      landmark_ids: params[:figure][:landmark_ids]
    })
    
    if params[:title][:name] != "" 
      @figure.titles << Title.create({name: params[:title][:name]})
    end

    if params[:landmark][:name] != ""
      @figure.landmarks << Landmark.create({name: params[:landmark][:name], year_completed: params[:landmark][:year_complete]})
    end

    redirect '/figures'
  end

  # get specific figure 
  get ('/figures/:id') do
    @figure = Figure.find(params[:id])
    erb :"figures/show"
  end

  get ('/figures/:id/edit') do
    @figure = Figure.find(params[:id])
    erb :"figures/edit"
  end

  patch ('/figures/:id') do
    @figure = Figure.find(params[:id])
    @figure.update({
      name: params[:figure][:name],
      title_ids: params[:figure][:title_ids],
      landmark_ids: params[:figure][:landmark_ids]
    })
    if params[:title][:name] != "" 
      @figure.titles << Title.create({name: params[:title][:name]})
    end

    if params[:landmark][:name] != ""
      @figure.landmarks << Landmark.create({name: params[:landmark][:name], year_completed: params[:landmark][:year_complete]})
    end
    redirect '/figures'

  end



end
