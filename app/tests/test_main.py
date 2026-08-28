from fastapi.testclient import TestClient

from main import app


client = TestClient(app)


def test_home():
    response = client.get("/")

    assert response.status_code == 200
    assert response.json() == {"message": "Hello, DevOps!"}


def test_echo():
    test_data = {
        "name": "Mahmood",
        "project": "CloudShip",
    }

    response = client.post("/echo", json=test_data)

    assert response.status_code == 200
    assert response.json() == test_data


def test_health():
    response = client.get("/health")

    assert response.status_code == 200
    assert response.json() == {"status": "healthy"}
