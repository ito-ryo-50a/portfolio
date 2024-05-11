# == Schema Information
#
# Table name: recipe_details
#
#  id            :bigint           not null, primary key
#  cooking_steps :integer
#  description   :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  recipe_id     :bigint           not null
#
# Indexes
#
#  index_recipe_details_on_recipe_id  (recipe_id)
#
# Foreign Keys
#
#  fk_rails_...  (recipe_id => recipes.id)
#
class RecipeDetail < ApplicationRecord
  belongs_to :recipe
  validates :description, presence: true
end