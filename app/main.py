from fastapi import FastAPI

app = FastAPI(title="CloudShip API")


@app.get("/")
def home():
    return {"message": "Hello, DevOps!"}


@app.post("/echo")
def echo(data: dict):
    return data


@app.get("/health")
def health():
    return {"status": "healthy"}
