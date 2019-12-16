from requests import get
from requests.exceptions import RequestException
from contextlib import closing
from bs4 import BeautifulSoup as soup
import requests
import time
import pandas as pd


def url_check(url, multiplier=1):
    """
    Makes http request. If HTML or XML format is found, will return text, otherwise return none
    """
    try:
        with requests.get(url) as fb:
            if is_good_response(fb):
                if len(fb.text) > 0:
                    print('Pass')
                else:
                    print('Fail')
            return fb.text

    except RequestException as e:
        log_errors('Error during request to {0} : {1}'.format(url, str(e)))
        return None


def is_good_response(resp):
    """
    Will return True if response is HTML. Will return False if otherwise
    """
    content_type = resp.headers['Content-Type'].lower()
    return(resp.status_code == 200
           and content_type is not None
           and content_type.find('html') > -1)


def get_data():
    year = str(input('Enter the year: '))
    raw = url_check(f"https://www.basketball-reference.com/leagues/NBA_{year}_totals.html")
    html = soup(raw, 'html.parser')
# Gets headers from table
    headers = [th.getText()
               for th in html.findAll('tr', limit=2)[0].findAll('th')]
    headers = [tag.replace('%', '') for tag in headers[1:]]
    rows = html.findAll('tr')[1:]
    player_stats = [[td.getText() for td in rows[i].findAll('td')]
                    for i in range(len(rows))]
    data = pd.DataFrame(player_stats, columns = headers)
    export_csv = data.to_csv(r'C:\Users\Public\Documents\NBA Data\export%(year)s.csv' % locals(), index = None, header=True)


def log_errors(e):
    print(e)

# Invoke the program
get_data()
