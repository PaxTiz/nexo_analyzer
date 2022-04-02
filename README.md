# Nexo Analyzer
A simple tool to report how much is generated for a Nexo account.

The tool reads a CSV file that is exported from the Nexo dashboard containaing all
transactions related to an account. You can choose to see how much you won for 
all time, for a given date (month/year) or even for a specific currency.

## Why Dart ?
Because why not ?

## Usage
```
usage: nexo [--month] [--year] [--currency] {month|each-month|total|currency}
options:
  --month       filter on that month, 1-12
  --year        filter on that year
  --currency    filter on that currency, for a specific month/year or whole time
```
