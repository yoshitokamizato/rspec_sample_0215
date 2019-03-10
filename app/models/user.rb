class User < ApplicationRecord
  attr_accessor :name, :age

  validates :name, :age, presence: true
  validates :age, numericality: {greater_than: 5}

  FAVORITE_FOODS = ["焼きそば", "寿司"].freeze

  def initialize(name:, age:)
    self.name = name
    self.age = age
  end

  def greet
    if @age <= 12
      "ぼくは#{@name}だよ。"
    else
      "僕は#{@name}です。"
    end
  end

  def favorite_food(foods)
    foods & FAVORITE_FOODS
  end
end
