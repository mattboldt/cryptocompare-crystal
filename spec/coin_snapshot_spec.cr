require "./spec_helper"

CRYPTOCURRENCY_DATA_KEYS = %w[
  Algorithm
  ProofType
  BlockNumber
  NetHashesPerSecond
  TotalCoinsMined
  BlockReward
  AggregatedData
  Exchanges
]

FIAT_DATA_KEYS = %w[
  AggregatedData
  Exchanges
]

AGGREGATED_DATA_KEYS = %w[
  TYPE
  MARKET
  FROMSYMBOL
  TOSYMBOL
  FLAGS
  PRICE
  LASTUPDATE
  LASTVOLUME
  LASTVOLUMETO
  LASTTRADEID
  VOLUME24HOUR
  VOLUME24HOURTO
  OPEN24HOUR
  HIGH24HOUR
  LOW24HOUR
  LASTMARKET
]

EXCHANGE_KEYS = %w[
  TYPE
  MARKET
  FROMSYMBOL
  TOSYMBOL
  FLAGS
  PRICE
  LASTUPDATE
  LASTVOLUME
  LASTVOLUMETO
  LASTTRADEID
  VOLUME24HOUR
  VOLUME24HOURTO
  OPEN24HOUR
  HIGH24HOUR
  LOW24HOUR
]

describe Cryptocompare::CoinSnapshot do

  it "should find_coin_snapshot_cryptocurrency_to_fiat" do
    resp = Cryptocompare::CoinSnapshot.find("BTC", "USD")

    resp["Response"].should eq("Success")

    CRYPTOCURRENCY_DATA_KEYS.each do |data_key|
      resp["Data"].as_h.has_key?(data_key).should eq(true)
    end

    AGGREGATED_DATA_KEYS.each do |agg_data_key|
      resp["Data"]["AggregatedData"].as_h.has_key?(agg_data_key).should eq(true)
    end

    resp["Data"]["Exchanges"].each do |exchange|
      EXCHANGE_KEYS.each do |exchange_key|
        exchange.as_h.has_key?(exchange_key).should eq(true)
      end
    end
  end

  it "should find_coin_snapshot_cryptocurrency_to_cryptocurrency" do

    resp = Cryptocompare::CoinSnapshot.find("ETH", "BTC")

    resp["Response"].should eq("Success")

    CRYPTOCURRENCY_DATA_KEYS.each do |data_key|
      resp["Data"].as_h.has_key?(data_key).should eq(true)
    end

    AGGREGATED_DATA_KEYS.each do |agg_data_key|
      resp["Data"]["AggregatedData"].as_h.has_key?(agg_data_key).should eq(true)
    end

    resp["Data"]["Exchanges"].each do |exchange|
      EXCHANGE_KEYS.each do |exchange_key|
        exchange.as_h.has_key?(exchange_key).should eq(true)
      end
    end

  end

  it "should find_coin_snapshot_fiat_to_cryptocurrency" do
    resp = Cryptocompare::CoinSnapshot.find("USD", "ETH")

    resp["Response"].should eq("Success")

    FIAT_DATA_KEYS.each do |data_key|
      resp["Data"].as_h.has_key?(data_key).should eq(true)
    end

    AGGREGATED_DATA_KEYS.each do |agg_data_key|
      resp["Data"]["AggregatedData"].as_h.has_key?(agg_data_key).should eq(true)
    end

    resp["Data"]["Exchanges"].each do |exchange|
      EXCHANGE_KEYS.each do |exchange_key|
        exchange.as_h.has_key?(exchange_key).should eq(true)
      end
    end
  end

  it "should find_coin_snapshot_fiat_to_fiat" do

    resp = Cryptocompare::CoinSnapshot.find("EUR", "USD")

    resp["Response"].should eq("Success")

    FIAT_DATA_KEYS.each do |data_key|
      resp["Data"].as_h.has_key?(data_key).should eq(true)
    end

    AGGREGATED_DATA_KEYS.each do |agg_data_key|
      resp["Data"]["AggregatedData"].as_h.has_key?(agg_data_key).should eq(true)
    end

    resp["Data"]["Exchanges"].each do |exchange|
      EXCHANGE_KEYS.each do |exchange_key|
        exchange.as_h.has_key?(exchange_key).should eq(true)
      end
    end

  end
end
