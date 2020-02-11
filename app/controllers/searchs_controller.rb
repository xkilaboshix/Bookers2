class SearchsController < ApplicationController
  before_action :authenticate_user!

  # 名前検索機能
  def search

    if params[:select_a] == "User" && params[:select_b] == "完全一致"
      @users = User.where(['name LIKE ?', "#{params[:search]}"])

    elsif params[:select_a] == "User" && params[:select_b] == "前方一致"
      @users = User.where(['name LIKE ?', "#{params[:search]}%"])

    elsif params[:select_a] == "User" && params[:select_b] == "後方一致"
      @users = User.where(['name LIKE ?', "%#{params[:search]}"])

    elsif params[:select_a] == "User" && params[:select_b] == "部分一致"
      @users = User.where(['name LIKE ?', "%#{params[:search]}%"])


    elsif params[:select_a] == "Book" && params[:select_b] == "完全一致"
      @books = Book.where(['title LIKE ?', "#{params[:search]}"])

    elsif params[:select_a] == "Book" && params[:select_b] == "前方一致"
      @books = Book.where(['title LIKE ?', "#{params[:search]}%"])

    elsif params[:select_a] == "Book" && params[:select_b] == "後方一致"
      @books = Book.where(['title LIKE ?', "%#{params[:search]}"])

    elsif params[:select_a] == "Book" && params[:select_b] == "部分一致"
      @books = Book.where(['title LIKE ?', "%#{params[:search]}%"])
    end
  end
end
