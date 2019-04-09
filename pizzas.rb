require 'json'
require_relative 'spec/spec_helper'
require 'pry'

# This method returns receives as argument a list of ingredients and
# returns all combinations of ingredients for a pizza.
# @param ingredients [Array<String>]
# @return [JSON]
def make_pizzas(ingredients = [])
  ingredient_combinations = ingredients.combination(3).to_a

  ingredient_combinations.reduce(pizzas: []) do |pizzas, ingredients|
    pizza = { ingredients: ingredients }
    pizzas[:pizzas] << pizza

    pizzas
  end.to_json
end


RSpec.describe "make_pizzas" do
  context "let's do pizzas" do
    let(:ingredients){ %w(jamon pina cebolla peperoni) }
    let(:pizzas_with_ingredients) do
      {
        pizzas: [
          { ingredients: %w(jamon pina cebolla) },
          { ingredients: %w(jamon pina peperoni) },
          { ingredients: %w(jamon cebolla peperoni) },
          { ingredients: %w(pina cebolla peperoni) }
        ]
      }
    end

    it "returns pizzas' ingredients" do
      pizzas = JSON.parse(make_pizzas(ingredients), symbolize_names: true)
      expect(pizzas).to have_key(:pizzas)

      expect(pizzas).to eq(pizzas_with_ingredients)
    end
  end
end
