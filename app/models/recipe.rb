class Recipe

  attr_accessor :name, :rating, :id, :image_url, :total_time

  def initialize(name, rating, id, image_url, total_time)
    @name = name
    @rating = rating
    @id = id
    @image_url = image_url
    @total_time = total_time
  end

end
