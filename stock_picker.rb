
def stock_picker(prices_per_day)

  days_profit = {}

  day_to_buy = -1

  prices_per_day.each { |price_to_buy|
    day_to_buy += 1
    day_to_sell = day_to_buy + 1

    remaining_days_to_sell = prices_per_day[day_to_sell..-1]

    remaining_days_to_sell.each { |price_to_sell|
      days_profit[[day_to_buy, day_to_sell]] = price_to_sell - price_to_buy
      day_to_sell += 1
    } }

  return [0, 0] if days_profit.values.max < 0 #if unable to get profit
  days_profit.key(days_profit.values.max)
end

