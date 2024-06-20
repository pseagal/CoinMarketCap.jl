module PriceConverter

export PriceConverterQuery,
    PriceConverterData,
    price_converter


using Serde
using Dates, NanoDates, TimeZones
using CryptoAPIs.CoinMarketCap
using CryptoAPIs: Maybe, APIsRequest

Base.@kwdef struct PriceConverterQuery <: CoinMarketCapPublicQuery
    symbol::String
    convert::String
    amount::Maybe{Float64}
end

struct Quote
    price::Float64
    last_updated::String
end

struct DataEntry
    id::Int64
    name::String
    symbol::String
    amount::Float64
    last_updated::String
    quote::Dict{String, Quote}
    end
end

struct Status
    timestamp::String
    error_code::Int64
    error_message::Maybe{String}
    elapsed::Int64
    credit_count::Int64
    notice::Maybe{String}
end

struct PriceConverterData <: CoinMarketCapData 
    data::Vector{Any}
    status::Status
end


"""
    price_converter(client::CoinMarketCapClient, query::PriceConverterQuery)
    price_converter(client::CoinMarketCapClient = CoinMarketCap.Spot.public_client; kw...)

 Convert an amount of one cryptocurrency or fiat currency into one or 
 more different currencies utilizing the latest market rate for each currency.

[`GET /v2/tools/price-conversion`](https://pro-api.coinmarketcap.com/v2/tools/price-conversion)

## Parameters:

| Parameter | Type   | Required | Description |
|:----------|:-------|:---------|:------------|
| symbol    | String | true     |             |
| convert   | String | true     | comma-separated fiat or cryptocurrency symbols to convert the source amount to             |
| amount    | Float64| true     |             |


## Code samples:

```julia
using Serde
using CryptoAPIs.CoinMarketCap

result = CoinMarketCap.Spot.price_converter(;
    symbol = "BTC",
    convert = "USDT, ETH",
    amount = 10
) 

to_pretty_json(result.result)
```

## Result:

```json
{
  "mins":5,
  "price":0.64545824
}
```
"""
function price_converter(client::CoinMarketCapClient, query::PriceConverterQuery)
    return APIsRequest{PriceConverterData}("GET", "/v2/tools/price-conversion", query)(client)
end

function price_converter(client::CoinMarketCapClient = CoinMarketCap.Spot.public_client; kw...)
    return price_converter(client, PriceConverterQuery(; kw...))
end

end