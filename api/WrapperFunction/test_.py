
from fastapi.testclient import TestClient
from WrapperFunction import app

client = TestClient(app)

def test_read_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Welcome to the NPFL data API"}

def test_get_clubs():
    response = client.get("/clubs")
    assert response.status_code == 200
    assert len(response.json()) > 0

def test_get_club_by_name():
    response = client.get("/clubs/heartland")
    assert response.status_code == 200

def test_get_clubs_by_titles():
    response = client.get("/clubs/by-titles-won?min_titles=5")
    assert len(response.json()) > 0
    
# setup ci/cd pipeline with github actions to run tests on push to main branch