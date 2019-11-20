import requests

HOST = "australia-test.azurewebsites.net"
HTTP_URL = f"http://{HOST}/"
HTTPS_URL = f"https://{HOST}/"


def test_responds_to_http():
    r = requests.get(HTTP_URL)
    r.raise_for_status()


def test_responds_to_https():
    r = requests.get(HTTPS_URL)
    r.raise_for_status()


def test_forces_https():
    r = requests.get(HTTP_URL)
    # https://requests.readthedocs.io/en/master/user/quickstart/#redirection-and-history
    assert r.url == HTTPS_URL
