import pickle

def predict_class(sepal_length, sepal_width, petal_length, petal_width):
    with open('models/best_model.pkl', 'rb') as f:
        model = pickle.load(f)

    prediction = model.predict([[sepal_length, sepal_width, petal_length, petal_width]])

    return prediction