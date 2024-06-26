class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :require_login, only: %i[new create edit update destroy]
  skip_before_action :require_login, only: %i[index show]

  def index
    @recipes = Recipe.page(params[:page]).per(10).order(updated_at: :desc)
  end

  def show
    @comment = Comment.new
    @comments = @recipe.comments.includes(:user).order(created_at: :desc)
  end

  def new; end

  def create
    # ユーザーの入力値をフォームから取得
    cuisine_type = params[:cuisine_type]
    dish_type = params[:dish_type]
    ingredient1 = params[:ingredient1]
    ingredient2 = params[:ingredient2]
    ingredient3 = params[:ingredient3]
    number = params[:number]
    additional_ingredient_suggestions = params[:additional_ingredient_suggestions]
    allergy_restrictions = params[:allergy_restrictions]
    cooking_time = params[:cooking_time]

    # OpenAI APIへリクエストを送信する
    headers = {
      'Authorization' => "Bearer #{ENV.fetch('OPENAI_API_KEY', nil)}",
      'Content-Type' => 'application/json'
    }

    body = {
      model: 'gpt-3.5-turbo',
      messages: [
        {
          role: 'system',
          content: 'You are a professional chef using a household microwave at 500W or 600W. Create one dish per generation, assuming basic kitchen tools are available.'
        },
        {
          role: 'user',
          content: "Generate a recipe based on the following details:
          Cuisine type: #{cuisine_type},
          Dish type: #{dish_type},
          Ingredients: #{ingredient1}, #{ingredient2}, #{ingredient3}, # Ensure these ingredients are always used
          Number of servings: #{number},
          Additional ingredients allowed: #{additional_ingredient_suggestions},
          Allergies: #{allergy_restrictions},
          Maximum cooking time: #{cooking_time} minutes,
          Output should include:
          Dish name: A concise, imaginative name.
          Cooking time: In minutes, not exceeding #{cooking_time} minutes.
          Ingredients: No more than 7, format:-ingredient_name:quantity
          Cooking steps: Use a 500W or 600W household microwave for all steps. Describe in 3 concise steps, all in Japanese within 300 tokens."
        }
      ]
    }

    response = Faraday.post('https://api.openai.com/v1/chat/completions', body.to_json, headers)

    # レスポンスデータのパースを行う
    response_data = JSON.parse(response.body).dig('choices', 0, 'message', 'content')

    # レシピの作成処理の箇所
    @recipe = Recipe.new(
      user_id: current_user.id,
      name: response_data.split('Dish name: ')[1].split('Cooking time:')[0].strip,
      cooking_time: response_data.split('Cooking time: ')[1].split('Ingredients:')[0].strip.to_i,
      cuisine_type: cuisine_type,
      dish_type: dish_type,
      number: number
    )
    # TODO: エラーハンドリング追加時にsaveの条件見直し（save可能であれば、残りのレスポンスはまとめてどこかのレコードに入れてユーザーに表示できるよう検討）
    if @recipe.save
      # 食材と分量を保存
      ingredients_text = response_data.split('Ingredients:')[1].split('Cooking steps:')[0].strip
      ingredients = ingredients_text.split("\n").map { |line| line.strip.sub(/^- /, '') }
      ingredients.each_with_index do |ingredient, _index|
        ingredient_name, quantity = ingredient.split(':').map(&:strip)
        @recipe.recipe_ingredients.create(ingredient_name: ingredient_name, quantity: quantity)
      end

      # 調理手順を保存
      steps_text = response_data.split('Cooking steps:')[1].strip
      steps = steps_text.split("\n")
      steps.each_with_index do |step, index|
        @recipe.recipe_procedures.create(order: index + 1, procedure: step)
      end

      redirect_to recipe_path(@recipe), notice: 'レシピを作成しました。'
    else
      flash.now[:alert] = 'レシピの作成に失敗しました。'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    recipe = Recipe.find(params[:id])
    recipe.update!(recipe_params)
    redirect_to recipe_path(recipe), notice: 'レシピを更新しました。'
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to recipes_path, notice: 'レシピを削除しました。', status: :see_other
  end

  def bookmarks
    @bookmark_recipes = current_user.bookmark_recipes.page(params[:page]).per(10).order(updated_at: :desc)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :cooking_time, :cuisine_type, :dish_type, :number,
                                   recipe_ingredients_attributes: %i[id ingredient_name quantity _destroy],
                                   recipe_procedures_attributes: %i[id order procedure _destroy])
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
