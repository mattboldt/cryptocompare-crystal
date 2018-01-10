# cryptocompare-crystal

[![Travis CI Build Status](https://travis-ci.org/mattboldt/cryptocompare-crystal.svg)](https://travis-ci.org/mattboldt/cryptocompare-crystal)
[![GitHub release](https://img.shields.io/github/release/mattboldt/cryptocompare-crystal.svg)]()
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/mattboldt/typed.js/master/LICENSE.txt)

This is a Crystal Shard that utilizes the [CryptoCompare API](https://www.cryptocompare.com/api/) to fetch data related to cryptocurrencies.

Port of [Ruby Cryptocompare](https://github.com/alexanderdavidpan/cryptocompare)

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  cryptocompare:
    github: mattboldt/cryptocompare-crystal
```

## Usage

```crystal
require "cryptocompare"
```

### Price

Finds the currency price(s) of a given currency symbol.

**Examples:**

Convert cryptocurrency to fiat.

```crystal
Cryptocompare::Price.find("BTC", "USD")
# => {"BTC"=>{"USD"=>2594.07}}
```

Convert fiat to cryptocurrency.

```crystal
Cryptocompare::Price.find("USD", "BTC")
# => {"USD"=>{"BTC"=>0.0004176}}
```

Convert cryptocurrency to cryptocurrency.

```crystal
Cryptocompare::Price.find("BTC", "ETH")
# => {"BTC"=>{"ETH"=>9.29}}
```

Convert fiat to fiat.

```crystal
Cryptocompare::Price.find("USD", "EUR")
# => {"USD"=>{"EUR"=>0.8772}}
```

Convert multiple cryptocurrencies to multiple fiat.

```crystal
Cryptocompare::Price.find(["BTC","ETH", "LTC"], ["USD", "EUR", "CNY"])
# => {"BTC"=>{"USD"=>2501.61, "EUR"=>2197.04, "CNY"=>17329.48}, "ETH"=>{"USD"=>236.59, "EUR"=>209.39, "CNY"=>1655.15}, "LTC"=>{"USD"=>45.74, "EUR"=>40.33, "CNY"=>310.5}}
```

Convert multiple fiat to multiple cryptocurrencies.

```crystal
Cryptocompare::Price.find(["USD", "EUR"], ["BTC","ETH", "LTC"])
# => {"USD"=>{"BTC"=>0.0003996, "ETH"=>0.004238, "LTC"=>0.02184}, "EUR"=>{"BTC"=>0.0004548, "ETH"=>0.00477, "LTC"=>0.0248}}
```

Convert prices based on exchange.

```crystal
Cryptocompare::Price.find("DASH", "USD", {"e" => "Kraken"})
# => {"DASH"=>{"USD"=>152.4}}
```

Get full price info (raw and display) for cryptocurrency to fiat currency.
```crystal
Cryptocompare::Price.full("BTC", "USD")
# => {
#   "RAW" => {
#     "BTC" => {
#       "USD" => {
#         "TYPE"=>"5",
#         "MARKET"=>"CCCAGG",
#         "FROMSYMBOL"=>"BTC",
#         "TOSYMBOL"=>"USD",
#         "FLAGS"=>"4",
#         "PRICE"=>4551.84,
#         "LASTUPDATE"=>1504753702,
#         "LASTVOLUME"=>2.19e-06,
#         "LASTVOLUMETO"=>0.00995355,
#         "LASTTRADEID"=>20466080,
#         "VOLUME24HOUR"=>110449.85666195827,
#         "VOLUME24HOURTO"=>503369392.8440719,
#         "OPEN24HOUR"=>4497.45,
#         "HIGH24HOUR"=>4667.51,
#         "LOW24HOUR"=>4386.51,
#         "LASTMARKET"=>"Coinbase",
#         "CHANGE24HOUR"=>54.39000000000033,
#         "CHANGEPCT24HOUR"=>1.2093519661141388,
#         "SUPPLY"=>16549137,
#         "MKTCAP"=>75329023762.08
#       }
#     }
#   },
#   "DISPLAY" => {
#     "BTC" => {
#       "USD" => {
#         "FROMSYMBOL"=>"Ƀ",
#         "TOSYMBOL"=>"$",
#         "MARKET"=>"CryptoCompare Index",
#         "PRICE"=>"$ 4,551.84",
#         "LASTUPDATE"=>"Just now",
#         "LASTVOLUME"=>"Ƀ 0.00000219",
#         "LASTVOLUMETO"=>"$ 0.009954",
#         "LASTTRADEID"=>20466080,
#         "VOLUME24HOUR"=>"Ƀ 110,449.9",
#         "VOLUME24HOURTO"=>"$ 503,369,392.8",
#         "OPEN24HOUR"=>"$ 4,497.45",
#         "HIGH24HOUR"=>"$ 4,667.51",
#         "LOW24HOUR"=>"$ 4,386.51",
#         "LASTMARKET"=>"Coinbase",
#         "CHANGE24HOUR"=>"$ 54.39",
#         "CHANGEPCT24HOUR"=>"1.21",
#         "SUPPLY"=>"Ƀ 16,549,137",
#         "MKTCAP"=>"$ 75.33 B"
#       }
#     }
#   }
# }
```

Generate average price for cryptocurrency to fiat currency.

```crystal
Cryptocompare::Price.generate_avg("BTC", "USD", ["Coinbase", "Bitfinex"])
# => {
#   "RAW" => {
#     "MARKET" => "CUSTOMAGG",
#     "FROMSYMBOL" => "BTC",
#     "TOSYMBOL" => "USD",
#     "FLAGS" => 0,
#     "PRICE" => 4137.43,
#     "LASTUPDATE" => 1503454563,
#     "LASTVOLUME" => 2,
#     "LASTVOLUMETO" => 8271.98,
#     "LASTTRADEID" => 19656029,
#     "VOLUME24HOUR" => 71728.71957884016,
#     "VOLUME24HOURTO" => 279374718.3442189,
#     "OPEN24HOUR" => 3885.85,
#     "HIGH24HOUR" => 4145,
#     "LOW24HOUR" => 3583.46,
#     "LASTMARKET" => "Coinbase",
#     "CHANGE24HOUR" => 251.58000000000038,
#     "CHANGEPCT24HOUR" => 6.474259171095137
#   },
#   "DISPLAY" => {
#     "FROMSYMBOL" => "Ƀ",
#     "TOSYMBOL" => "$",
#     "MARKET" => "CUSTOMAGG",
#     "PRICE" => "$ 4,137.43",
#     "LASTUPDATE" => "Just now",
#     "LASTVOLUME" => "Ƀ 2",
#     "LASTVOLUMETO" => "$ 8,271.98",
#     "LASTTRADEID" => 19656029,
#     "VOLUME24HOUR" => "Ƀ 71,728.7",
#     "VOLUME24HOURTO" => "$ 279,374,718.3",
#     "OPEN24HOUR" => "$ 3,885.85",
#     "HIGH24HOUR" => "$ 4,145",
#     "LOW24HOUR" => "$ 3,583.46",
#     "LASTMARKET" => "Coinbase",
#     "CHANGE24HOUR" => "$ 251.58",
#     "CHANGEPCT24HOUR" => "6.47"
#   }
# }
```

Get day average price.

```crystal
Cryptocompare::Price.day_avg("BTC", "USD")
# => {
#   "USD" => 4109.92,
#   "ConversionType" => {
#     "type" => "direct",
#     "conversionSymbol" => ""
#   }
# }
```

### PriceHistorical

Finds the price of any cryptocurrency in any other currency that you need at a given timestamp. The price comes from the daily info - so it would be the price at the end of the day GMT based on the requested timestamp. If the crypto does not trade directly into the toSymbol requested, BTC will be used for conversion. Tries to get direct trading pair data, if there is none or it is more than 30 days before the ts requested, it uses BTC conversion. If the opposite pair trades we invert it (eg.: BTC-XMR)

**Examples:**

Find historical price of cryptocurrency.

```crystal
Cryptocompare::PriceHistorical.find("ETH", "USD")
# => {"ETH"=>{"USD"=>225.93}}
```

Find historical price of cryptocurrency at a given timestamp.

```crystal
Cryptocompare::PriceHistorical.find("ETH", "USD", {"ts" => 1452680400})
# => {"ETH"=>{"USD"=>223.2}}
```

Find historical price of cryptocurrency in many currencies at a given timestamp.

```crystal
Cryptocompare::PriceHistorical.find("ETH", ["BTC", "USD", "EUR"], {"ts" => "1452680400"})
# => {"ETH"=>{"BTC"=>0.08006, "USD"=>225.93, "EUR"=>194.24}}
```

### CoinList

Get general info for all the coins available on Cryptocompare's API.

**Example:**

```crystal
Cryptocompare::CoinList.all
# => {
#     "Response" => "Success",
#     "Message" => "Coin list successfully returned!",
#     "BaseImageUrl" => "https://www.cryptocompare.com",
#     "BaseLinkUrl" => "https://www.cryptocompare.com",
#     "DefaultWatchlist" => {
#       "CoinIs" => "1182,7605,5038,24854,3807,3808,202330,5324,5031,20131",
#       "Sponsored" => ""
#     },
#     "Data" => {
#       "BTC" => {
#         "Id" => "1182",
#         "Url" => "/coins/btc/overview",
#         "ImageUrl" => "/media/19633/btc.png",
#         "Name" => "BTC",
#         "Symbol" => "BTC",
#         "CoinName" => "Bitcoin",
#         "FullName" => "Bitcoin (BTC)",
#         "Algorithm" => "SHA256",
#         "ProofType" => "PoW",
#         "FullyPremined" => "0",
#         "TotalCoinSupply" => "21000000",
#         "PreMinedValue" => "N/A",
#         "TotalCoinsFreeFloat" => "N/A",
#         "SortOrder" => "1",
#         "Sponsored" => false
#       },
#       "ETH" => {
#         "Id" => "7605",
#         "Url" => "/coins/eth/overview",
#         "ImageUrl" => "/media/20646/eth_logo.png",
#         "Name" => "ETH",
#         "Symbol" => "ETH",
#         "CoinName" => "Ethereum ",
#         "FullName" => "Ethereum (ETH)",
#         "Algorithm" => "Ethash",
#         "ProofType" => "PoW",
#         "FullyPremined" => "0",
#         "TotalCoinSupply" => "0",
#         "PreMinedValue" => "N/A",
#         "TotalCoinsFreeFloat" => "N/A",
#         "SortOrder" => "2",
#         "Sponsored" => false
#       },
#       ...
#     },
#     "Type" => 100
#   }
```

### CoinSnapshot

Get data for a currency pair. It returns general block explorer information, aggregated data and individual data for each exchange available.

**Example:**

```crystal
Cryptocompare::CoinSnapshot.find("BTC", "USD")
# => {
#     "Response":"Success",
#     "Message":"Coin snapshot successfully returned",
#     "Type":100,
#     "Data":{
#       "Algorithm":"SHA256",
#       "ProofType":"PoW",
#       "BlockNumber":378345,
#       "NetHashesPerSecond":465548431.66333866,
#       "TotalCoinsMined":14707625.0,
#       "BlockReward":25.0,
#       "AggregatedData":{
#         "TYPE":"5",
#         "MARKET":"CCCAGG",
#         "FROMSYMBOL":"BTC",
#         "TOSYMBOL":"USD",
#         "FLAGS":"4",
#         "PRICE":"245.41",
#         "LASTUPDATE":"1444520460",
#         "LASTVOLUME":"0.0086",
#         "LASTVOLUMETO":"2.110268",
#         "LASTTRADEID":"1444520460357",
#         "VOLUME24HOUR":"49591.48108707269",
#         "VOLUME24HOURTO":"12139110.189163648",
#         "OPEN24HOUR":"244.41",
#         "HIGH24HOUR":"258.37",
#         "LOW24HOUR":"239.01000004",
#         "LASTMARKET":"Huobi"
#       },
#       "Exchanges":[
#         {
#           "TYPE":"2",
#           "MARKET":"LakeBTC",
#           "FROMSYMBOL":"BTC",
#           "TOSYMBOL":"USD",
#           "FLAGS":"2",
#           "PRICE":"244.37",
#           "LASTUPDATE":"1444513131",
#           "LASTVOLUME":"0.03",
#           "LASTVOLUMETO":"7.3311",
#           "LASTTRADEID":"1444513131",
#           "VOLUME24HOUR":"3599.0560000000005",
#           "VOLUME24HOURTO":"879237.6299349999",
#           "OPEN24HOUR":"243.83",
#           "HIGH24HOUR":"245.23",
#           "LOW24HOUR":"242.68"
#         },
#         ....
#       ]
#     }
#   }
```

### TopPairs

Get top pairs by volume for a currency (always uses aggregated data). The number of pairs you get is the minimum of the limit you set (default 5) and the total number of pairs available.

**Examples:**

Find top pairs by trading volume for a given currency.

```crystal
Cryptocompare::TopPairs.find("ETH")
# => {
#   "Response" => "Success",
#   "Data" => [
#     {
#       "exchange" => "CCCAGG",
#       "fromSymbol" => "ETH",
#       "toSymbol" => "USD",
#       "volume24h" => 1310705.3005027298,
#       "volume24hTo" => 288031723.3503975
#     },
#     {
#       "exchange" => "CCCAGG",
#       "fromSymbol" => "ETH",
#       "toSymbol" => "BTC",
#       "volume24h" => 978200.2198323006,
#       "volume24hTo" => 77883.06190085363
#     },
#     ...
#   ]
# }
```

### HistoMinute

Get open, high, low, close, volumefrom and volumeto for each minute of historical data. This data is only stored for 7 days, if you need more, use the hourly or daily path. It uses BTC conversion if data is not available because the coin is not trading in the specified currency.

**Examples:**

Find historical data by minute for BTC to USD.

```crystal
Cryptocompare::HistoMinute.find("BTC", "USD")
# => {
#   "Response" => "Success",
#   "Type" => 100,
#   "Aggregated" => true,
#   "Data" => [
#     {
#       "time" => 1502259120,
#       "close" => 3396.44,
#       "high" => 3397.63,
#       "low" => 3396.34,
#       "open" => 3397.39,
#       "volumefrom" => 98.2,
#       "volumeto" => 335485
#     },
#     {
#       "time" => 1502259300,
#       "close" => 3396.86,
#       "high" => 3396.94,
#       "low" => 3396.44,
#       "open" => 3396.44,
#       "volumefrom" => 16.581031,
#       "volumeto" => 56637.869999999995
#     },
#     ...
#   ],
#   "TimeTo" => 1502259360,
#   "TimeFrom" => 1502259120,
#   "FirstValueInArray" => true,
#   "ConversionType" => {
#     "type" => "direct",
#     "conversionSymbol" => ""
#   }
# }
```

### HistoHour

Get open, high, low, close, volumefrom and volumeto from the each hour historical data. It uses BTC conversion if data is not available because the coin is not trading in the specified currency.

**Examples:**

Find historical data by hour for BTC to USD.

```crystal
Cryptocompare::HistoHour.find("BTC", "USD")
# => {
#   "Response" => "Success",
#   "Type" => 100,
#   "Aggregated" => false,
#     "Data" => [
#     {
#       "time" => 1502259120,
#       "close" => 3396.44,
#       "high" => 3397.63,
#       "low" => 3396.34,
#       "open" => 3397.39,
#       "volumefrom" => 98.2,
#       "volumeto" => 335485
#     },
#     {
#       "time" => 1502259300,
#       "close" => 3396.86,
#       "high" => 3396.94,
#       "low" => 3396.44,
#       "open" => 3396.44,
#       "volumefrom" => 16.581031,
#       "volumeto" => 56637.869999999995
#     },
#     ...
#   ],
#   "TimeTo" => 1503248400,
#   "TimeFrom" => 1502643600,
#   "FirstValueInArray" => true,
#   "ConversionType" => {
#     "type" => "direct",
#     "conversionSymbol" => ""
#   }
# }
```

### HistoDay

Get open, high, low, close, volumefrom and volumeto daily historical data. The values are based on 00:00 GMT time. It uses BTC conversion if data is not available because the coin is not trading in the specified currency.

**Examples:**

Find historical data by day for BTC to USD.

```crystal
Cryptocompare::HistoDay.find("BTC", "USD")
# => {
#   "Response" => "Success",
#   "Type" => 100,
#   "Aggregated" => false,
#   "Data" => [
#     {
#       "time" => 1500854400,
#       "close" => 2763.42,
#       "high" => 2798.89,
#       "low" => 2715.69,
#       "open" => 2756.61,
#       "volumefrom" => 83009.25,
#       "volumeto" => 229047365.02
#     },
#     {
#       "time" => 1500940800,
#       "close" => 2582.58,
#       "high" => 2779.08,
#       "low" => 2472.62,
#       "open" => 2763.42,
#       "volumefrom" => 205883.15,
#       "volumeto" => 534765380.75
#     },
#     ...
#   ],
#   "TimeTo" => 1503446400,
#   "TimeFrom" => 1500854400,
#   "FirstValueInArray" => true,
#   "ConversionType" => {
#     "type" => "direct",
#     "conversionSymbol" => ""
#   }
# }
```

## Supported Exchanges
ANXBTC, Binance, Bit2C, BitBay, BitcoinDE, Bitfinex, bitFlyer, bitFlyerFX, Bithumb, BitMarket, Bitso, BitSquare, Bitstamp, Bittrex, Bleutrade, BTC38, BTCChina, BTCE, BTCMarkets, btcXchange, BTCXIndia, BTER, CCEDK, CCEX, Cexio, CHBTC, Coinbase, CoinCheck, CoinExchange, Coinfloor, Coinone, Coinroom, Coinse, Coinsetter, Cryptopia, CryptoX, Cryptsy, EtherDelta, EthexIndia, Exmo, Gatecoin, Gemini, HitBTC, Huobi, itBit, Jubi, Korbit, Kraken, LakeBTC, Liqui, LiveCoin, LocalBitcoins, Luno, Lykke, MercadoBitcoin, MonetaGo, MtGox, Novaexchange, OKCoin, Paymium, Poloniex, QuadrigaCX, Quoine, Remitano, TheRockTrading, Tidex, TuxExchange, Unocoin, Vaultoro, ViaBTC, WavesDEX, Yacuna, Yobit, Yunbi, Zaif

If no exchange option is specified, then the default "CCCAGG" is used. This is cryptocompare's aggregated data.

## Development

#### Clone
```
git clone git@github.com:mattboldt/cryptocompare-crystal.git
cd cryptocompare-crystal
crystal deps
```

#### Run tests
```
crystal spec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mattboldt/cryptocompare-crystal. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

### TODO

Get the remaining tests working, and maybe implement Crystal Minitest instead of the default.


## License

The shard is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
