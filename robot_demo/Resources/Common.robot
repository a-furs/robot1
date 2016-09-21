*** Settings ***
Library  ../Library/DemoLibrary.py
Library  RequestsChecker
Library  RequestsLogger
Library  String
Library  Collections
Library  requests
Library  ../Library/RequestsLogger.py
Library  ../Library/RequestsChecker.py

Variables   ../Configs/ResponseCodes.py          # значения HTTP Status Code
Variables   ../Configs/Variables.py              # переменные тестируемых методов
Variables   ../Configs/EnvironmentConfig.py      # переменные окружения