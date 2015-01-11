class RecipesController < ApplicationController

  def search
    # base url for api call
    url = 'http://api.yummly.com/v1/api/recipes?_app_id=c8c5d4f5&_app_key=1acced9ffcd11cc26a4e5136fefcc946&maxResult=10'

    # the page of results to fetch
    page = params['page'].to_i

    # the array of ingredients to searchf or
    ingredients = params['q'].strip.split(',')

    # loop over each ingredient and add the necessary parameters to the url
    ingredients.each do |ingredient|
      url += "&allowedIngredient[]=#{ingredient}"
    end

    # check if the user only wants results with images
    if params['images'] == '1'
      url += '&requirePictures=true'
      @images = 1
    end

    # calculate which result number to start with based on the page
    url += "&start=#{page * 10}"

    # make api request and parse the response as a json object
    response = RestClient.get(URI.encode(url))
    parsed_response = JSON.parse(response)

    # set up instance variables for use in our html page
    @recipes = []
    @ingredients = ingredients.join(', ')
    @q = params['q']
    @page = page
    @total_results = parsed_response['totalMatchCount']
    @total_pages = @total_results / 10

    # populate the @recipes array with our recipe objects that we parse from the json
    parsed_response['matches'].each do |match|
      @recipes << Recipe.new(match['recipeName'], match['rating'], match['id'], (match['imageUrlsBySize']['90'] if match['imageUrlsBySize']), (match['totalTimeInSeconds'].to_i / 60))
    end

    render "results"
  end

end
