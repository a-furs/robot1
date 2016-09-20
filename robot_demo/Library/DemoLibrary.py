# -*- coding: utf-8 -*-
import base64
import json

import requests
from random import randint
import logging


class DemoLibrary(object):

    """
    Библиотекадля для обучающего задния 1
    """
    def __init__(self):
        self.host = 'http://httpbin.org'

    def get_info(self, header_name, header_value):
        """
            Отправка запроса /get c хидером
            Принимает параметры header_name и header_value
            Возвращает ответ на запрос
        """
        url = '{}/get'.format(self.host)
        response = requests.get(url=url, headers={header_name: header_value})
        #response = requests.get(url=url)
        logging.info(url)
        return response

    def passwd(self, username, password):
        """
            Отправка запроса /basic-auth/{}/{} с параметрами username и password
            Принимает параметры username и password
            username и password в формате username:password кодирует в Base64 и использует это значение для basic-авторизации
            Возвращает ответ на запрос
        """
        url = '{}/basic-auth/{}/{}'.format(self.host, username, password)
        response = requests.get(url=url, auth=(username, password))
        logging.info(url)
        return response

    def stream(self, count):
        """
            Отправка запроса /stream/{} с параметром n - количество выводимых строк
            Принимает параметр n
            Возвращает ответ на запрос
        """
        url = '{}/stream/{}'.format(self.host, count)
        response = requests.get(url=url)
        logging.info(url)
        return response

    @staticmethod
    def get_rnd_value(min=0, max=100):
        """
            Возвращает рандомное значение в диапазоне от 0 до 100
        """
        rand_value = randint(min, max)
        return rand_value

    @staticmethod
    def get_strings_count_in_response(text):
        """
            Принимает параметр text - текст в котормо нужно посчитать количество строк
            Возвращает количество строк
        """
        string_count = text.count('\n')
        return string_count

    @staticmethod
    def get_header(response, header):
        """
            Принимает название хидера, значение которого нужно получить из респонса
            Возвращает значение хидера в респонсе
        """
        header_value = response.headers.get(header)
        return header_value

    @staticmethod
    def get_header_value_from_json(response, header_name):
        response_json = json.loads(response.text)
        header_value = response_json['headers'][header_name]
        return header_value
