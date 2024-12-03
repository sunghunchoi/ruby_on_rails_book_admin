class BooksController < ApplicationController
  protect_from_forgery except: [:destroy]
  before_action :set_book, only: [:show, :destroy]
  # 메소드를 불러오는 방법
  around_action :action_logger, only: [:destroy]
  # 메소드를 직접 작성하는 방법
  before_action do
    redirect_to access_denied_path if params[:token].blank?
  end

  def show
    @book = Book.find(params[:id])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    respond_to do |format|
      format.html { redirect_to "/books" }
      format.json { head :no_content }
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def action_logger
    Rails.logger.info "around-before"
    yield
    Rails.logger.info "around-after"
  end
end
