class SearchController < ApplicationController
  before_action :authenticate_user!

  def search
    method = params[:search_method]
    @word = params[:search_word]
    if params[:search_select] == "user_search"
      @users = User.search(method,@word)
    elsif params[:search_select] == "book_search"
      @books = Book.search(method,@word)
    end
  end

end
