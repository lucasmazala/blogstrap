class ArticlesController < ApplicationController
  include Paginable
  
  before_action :authenticate_user!, except: %i[index show] # aula 14 - 18 min
  before_action :set_article, only: %i[edit update destroy] 
  before_action :set_categories, only: %i[index new create edit update] # vai pegar a variável de instância no private "@categories" e passar para a view  
  # before_action diz que antes rodar alguma action é para fazer um determinado comando. 
  def index
    @archives = Article.group_by_month(:created_at, format: '%B %Y', locale: :en).count # Aula 18 17min e aula 25 3min. Usando a gem groupdate. A variável recebe umaa chave e um valor. Created_at e count
    
    #@categories = Category.sorted # Envia essa varíável para a view index em category. aula 16 23 min. AUla 17 13 min. cancelado aula 28
    category = @categories.find { |c| c.name == params[:category]} if params[:category].present? # É chamado em filter_by_category e em highlights - aula 16 32 min. Aula 17 15min(importante). Atualizado aula 28 7min
    month_year = @archives.find { |m| m[0] == params[:month_year]}&.first if params[:month_year].present? #aula 28 12min

    # includes é usado para evitar muitas queries desnecessárias N+1 - Aula 17 10:00 min
    @highlights = Article.includes(:category, :user)  
                  .filter_by_category(category)
                  .filter_by_archive(month_year) #aula 28 15 min
                  .desc_order
                  .first(3)# traz os 3 artigos mais recentes aula 16.  # includes é usado para evitar muitas queries desnecessárias N+1 - Aula 17 10:00 min
    
    highlights_ids = @highlights.pluck(:id).join(',') # separa os 3 primeiros IDS. Eles só serão exibidos nos highlights
    

    @articles = Article.includes(:category, :user) # aula 17
                       .without_highlights(highlights_ids) #organização aula 12 - 30min 
                       .filter_by_category(category)  
                       .filter_by_archive(month_year) #aula 18 26 min - atualizado por aula 28 12:26min
                       .desc_order    
                       .page(current_page) #usando kaminari para paginação.  aula 11 - 9:52 - https://github.com/kaminari/kaminari


  end

  def show
    @article = Article.includes(comments: :user).find(params[:id]) # aula 19 33min
    authorize @article 
  end 

  def new #cria o article vazio
    @article = current_user.articles.new
  end

  def create # pega os parâmetros para salvar 
    @article = current_user.articles.new(article_params)

    if @article.save
      redirect_to @article, notice: t('.success') #aula 26 26:19min
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end  # aula 7
    

  def update 
    if @article.update(article_params)
      redirect_to @article, notice: t('.success') #aula 26 26min
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy # aula 8 
    @article.destroy
    redirect_to root_path, status: :see_other ,  notice: t('.success')  #root_path diz para ir para a action index
  end

  private 

  def article_params 
    params.require(:article).permit(:title, :body, :category_id)
  end

  def set_article 
    @article = Article.find(params[:id])
    authorize @article # aula-15 30min
  end

  def set_categories 
    @categories = Category.sorted 
  end

end
