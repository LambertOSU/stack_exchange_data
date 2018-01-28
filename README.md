# Stack Exchange Data Dump
This repository contains an exploration of the quarterly data dump from [StackExchange](https://stackexchange.com/).

The raw data can be found [here](https://archive.org/details/stackexchange).

File | Description
--- | ---
**stackex_unpacker.sh** | Unzips the .7z files into appropriately named directories.
**stack_xml_to_mysql.sql**  | Loads the XML files into MySQL.
**batch_sql.sh** | Loads batches of data using *stack_xml_to_mysql.sql*.
**mysql_tools.py** | Tools for running MySQL queries from python.
