class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :find_article, only: %i[show edit update destroy]


  def index
    @q = Article.ransack(params[:q])
    @articles = @q.result.includes(:user, :comments).page(params[:page]).per(5)
  end

  def show

  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.create(article_params)

    if @article.save
      redirect_to @article, notice: "Article created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end 

  def edit
    
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Article is updated"
    else
      render :edit, status: :unprocessable_entity
    end 
  end

  def destroy
    authorize @article
    @article.destroy

    redirect_to root_path, status: :see_other
  end


  private 

  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :document, :video, images: [])
  end
end
