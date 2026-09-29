from app import app


def client():
    app.config["TESTING"] = True
    return app.test_client()


def test_index_returns_message():
    resp = client().get("/")
    assert resp.status_code == 200
    assert "message" in resp.get_json()


def test_health_ok():
    resp = client().get("/health")
    assert resp.status_code == 200
    assert resp.get_json() == {"status": "ok"}


def test_metrics_exposed():
    c = client()
    c.get("/")  # generate at least one sample
    resp = c.get("/metrics")
    assert resp.status_code == 200
    assert b"app_requests_total" in resp.data
