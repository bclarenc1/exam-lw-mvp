from fastapi import FastAPI
import pickle

from pack.iris import predict_class

app = FastAPI()


@app.get("/")
def root():
    return {"greeting": "hello"}


@app.get("/predict")
def predict(sepal_length: float, sepal_width: float, petal_length: float, petal_width: float):
    """Return a prediction based on the pickled model"""
    
    prediction = predict_class(sepal_length, sepal_width, petal_length, petal_width)
    
    return {"prediction": float(prediction[0])}