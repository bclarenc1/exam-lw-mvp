import os

import streamlit as st
import requests

api_url = st.secrets["API_BASE_URL"]
assert api_url is not None, "Oops, environment variable 'API_URL' is not defined. Please complain to the dev"
# api_url="http://localhost:8000"

st.title("Iris predictor")

sl = st.slider('Sepal length', min_value=0., max_value=8., value=5., step=.1)
sw = st.slider('Sepal width',  min_value=0., max_value=5., value=3., step=.1)
pl = st.slider('Petal length', min_value=0., max_value=7., value=4., step=.1)
pw = st.slider('Petal width',  min_value=0., max_value=3., value=1., step=.1)


try:
    response = requests.get(
        f"{api_url}/predict?sepal_length={sl}&sepal_width={sw}&petal_length={pl}&petal_width={pw}",
        timeout=15)  # timeout is in seconds
    if response.status_code == 200:
        prediction = response.json()["prediction"]
        species_names = ["Setosa", "Versicolor", "Virginica"]
        st.write(f"This flower belongs to category: **{species_names[int(prediction)]}**")
    else:
        st.error("Error calling API")
except Exception as e:
    st.error(f"Error: {e}")
