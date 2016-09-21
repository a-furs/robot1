# -*- coding: utf-8 -*-
import requests
import RequestsLogger


class DemoLibrary(object):
    """
        Библиотекадля для обучающего задния 1
    """

    def get_request(self, host, header_name, header_value):
        """
            Отправка запроса /get c хидером
            Принимает параметры header_name и header_value
            Возвращает ответ на запрос
        """
        url = '{}/get'.format(host)
        response = requests.get(url=url, headers={header_name: header_value})
        RequestsLogger.write_log(response)
        return response

    def basic_auth_request(self, host, usernameUrl, passwordUrl, usernameBasicAuth, passwordBasicAuth):
        """
            Отправка запроса /basic-auth/{}/{} с параметрами usernameURL и passwordURL
            usernameURL, passwordURL используются для формирования URL
            usernameBasicAuth и  passwordBasicAuth используются это значение для basic-авторизации
            Возвращает ответ на запрос
        """
        url = '{}/basic-auth/{}/{}'.format(host, usernameUrl, passwordUrl)
        response = requests.get(url=url, auth=(usernameBasicAuth, passwordBasicAuth))
        RequestsLogger.write_log(response)
        return response

    def stream_request(self, host, count):
        """
            Отправка запроса /stream/{} с параметром n - количество выводимых строк
            Принимает параметр n
            Возвращает ответ на запрос
        """
        url = '{}/stream/{}'.format(host, count)
        response = requests.get(url=url)
        # fix, чтобы write_log не падал из-за невалидного JSON, возвращаемого /stream/:n
        response.headers['Content-Type'] = 'text'
        RequestsLogger.write_log(response)
        return response
