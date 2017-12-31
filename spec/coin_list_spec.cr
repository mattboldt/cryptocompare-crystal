require "./spec_helper"

COINLIST_TOP_LEVEL_RESPONSE_KEYS = %w[
  Response
  Message
  BaseImageUrl
  BaseLinkUrl
  DefaultWatchlist
  Data
  Type
]

COIN_DATA_KEYS = %w[
  Id
  Url
  Name
  Symbol
  CoinName
  FullName
  Algorithm
  ProofType
  FullyPremined
  TotalCoinSupply
  PreMinedValue
  TotalCoinsFreeFloat
  SortOrder
  Sponsored
]

describe Cryptocompare::CoinList do
  it "should return list of coins" do
    resp = Cryptocompare::CoinList.all

    COINLIST_TOP_LEVEL_RESPONSE_KEYS.each do |data_key|
      resp.as_h.has_key?(data_key).should eq(true)
    end

    resp["Data"].each do |coin, coin_data|
      COIN_DATA_KEYS.each do |data_key|
        coin_data.as_h.has_key?(data_key).should eq(true)
      end
    end
  end
end
