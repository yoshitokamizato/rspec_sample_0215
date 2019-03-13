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
    boy? ? "ぼくは#{@name}だよ。" : "僕は#{@name}です。"
  end

  def boy?
    self.age <= 12
  end

  def self.build_child
    User.new(name: 'たろう', age: 6)
  end

  def favorite_food(foods)
    foods & FAVORITE_FOODS
  end
end
