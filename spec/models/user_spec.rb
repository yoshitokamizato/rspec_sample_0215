require 'rails_helper'

RSpec.describe User, type: :model do
  describe "四則演算" do
    describe "足し算" do
      it '1 + 1 = 2' do
        expect(1+1).to eq 2
      end
    end
    describe "引き算" do
      it '1 - 9 = 10' do
        expect(1-9).to eq -8
      end
    end
  end

  describe '#greet' do
    it '12歳以下の場合、ひらがなで答えること' do
      user = User.new(name: 'たろう', age: 12)
      expect(user.greet).to eq 'ぼくはたろうだよ。'
    end
    it '13歳以上の場合、漢字で答えること' do
      user = User.new(name: 'たろう', age: 13)
      expect(user.greet).to eq '僕はたろうです。'
    end
  end

  describe '#greet' do
    context '12歳以下の場合' do
      it 'ひらがなで答えること' do
        user = User.new(name: 'たろう', age: 12)
        expect(user.greet).to eq 'ぼくはたろうだよ。'
      end
    end
    context '13歳以上の場合' do
      it '漢字で答えること' do
        user = User.new(name: 'たろう', age: 13)
        expect(user.greet).to eq '僕はたろうです。'
      end
    end
  end

  describe "#greet" do
    before do
      @params = {name: 'たろう'}
    end
    context '12歳以下の場合' do
      it 'ひらがなで答えること' do
        user = User.new(@params.merge!({age: 12}))
        expect(user.greet).to eq 'ぼくはたろうだよ。'
      end
    end
    context '13歳以上の場合' do
      it '漢字で答えること' do
        user = User.new(@params.merge!({age: 13}))
        expect(user.greet).to eq '僕はたろうです。'
      end
    end
  end

  describe "#greet" do
    let(:user) { User.new(params) }
    let(:params) { {name: 'たろう', age: age} }
    context '12歳以下の場合' do
      let(:age) { 12 }
      it 'ひらがなで答えること' do
        expect(user.greet).to eq 'ぼくはたろうだよ。'
      end
    end
    context '13歳以上の場合' do
      let(:age) { 13 }
      it '漢字で答えること' do
        expect(user.greet).to eq '僕はたろうです。'
      end
    end
  end

  describe "Favorite Foods" do
    let(:user) { User.new(params) }
    let(:params) { {name: 'たろう', age: age} }
    context '好きな食べ物の場合' do
      let(:age) { 22 }
      let(:foods) { ["焼きそば", "寿司"] }
      it '焼きそば、寿司が返ってくること' do
        expect(user.favorite_food(foods)).to eq ["焼きそば", "寿司"]
      end
    end

    context '好きな食べ物の場合' do
      let(:age) { 22 }
      let(:foods) { ["焼きそば", "たまねぎ"] }
      it '焼きそば、寿司が返ってくること' do
        expect(user.favorite_food(foods)).to eq ["焼きそば"]
      end
    end

    context '嫌いな食べ物の場合' do
      let(:age) { 22 }
      let(:foods) { ["カレー", "エビフライ"] }
      it '空の配列が帰ってくること' do
        expect(user.favorite_food(foods)).to be_empty
      end
    end
  end

  describe 'varidate' do
    let(:user) { User.new(params) }
    let(:params) { {name: 'たろう', age: age} }

    context '5歳以上の場合' do
      let(:age) { 22 }
      it 'be true' do
        expect(user).to be_valid
      end
    end

    context '5歳以下の場合' do
      let(:age) { 3 }
      it 'be true' do
        expect(user).to_not be_valid
      end
    end
  end

  describe 'mock' do
    context 'あいさつができること' do
      it 'ぼくは~だよ、という返事が返ってくること' do
        user_mock = double('user')
        allow(user_mock).to receive(:boy?)

        user = User.new(name: 'たろう', age: 6)
        allow(user).to receive(:boy?).and_return(user_mock)
        expect{ user.greet }.not_to raise_error
      end

      it '子供が作成できること' do
        user_mock = double('user')
        allow(User).to receive(:build_child).and_return(user_mock)
        expect{ User.build_child }.not_to raise_error
      end
    end
  end

  it 'エラーが起きたら通知すること' do
    twitter_client_mock = double('Twitter client')
    # updateメソッドが呼ばれたらエラーを発生させる
    allow(twitter_client_mock).to receive(:update).and_raise('エラーが発生しました')

    weather_bot = WeatherBot.new
    allow(weather_bot).to receive(:twitter_client).and_return(twitter_client_mock)
    # notifyメソッドが呼ばれることを検証する
    weather_bot.tweet_forecast
    expect(weather_bot).to receive(:notify)

    # tweet_forecastメソッドを呼び出す
    # weather_botのnotifyメソッドが呼び出されたらテストはパスする
  end
end
