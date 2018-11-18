class CategoriesController < ApplicationController

 def show
  @categorie = Categorie.all
 end

end
