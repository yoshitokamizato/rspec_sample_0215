RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

describe 'RSpec 例' do
  it '3 * 3 は 9 になること' do
    expect(3 * 3).to eq 9
  end

  it '3になること' do
    expect(1+2).to eq 3
  end

  it '答えが3以上になること' do
    expect(1 * 4).to be >= 3
    expect(2 * 5).to be >= 3
    expect(2 * 2).to be >= 3
  end

  it '同じ値であること' do
    message1 = "hello"
    message2 = "hello"

    expect(message1[0]).to eq message2[0]

    hoge = { name: "hoge", age: 22}

    expect(hoge[:name]).to eq "hoge"

    # beで比較するとオブジェクトが異なる場合はテストが失敗する
    # expect(hoge[:name]).to be "hoge"
  end
end
