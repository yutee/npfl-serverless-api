# FastAPI app and routes

from fastapi import FastAPI
from .database import CosmosDB

app = FastAPI()
db = CosmosDB()

@app.get("/")
def read_root():
    return {"message": "Welcome to the NPFL data API"}

@app.get("/clubs")
def get_clubs():
    return db.get_clubs()

@app.get("/clubs/by-titles")
def get_clubs_by_titles(min_titles: int):
    clubs = db.get_clubs()
    filtered_clubs = [club for club in clubs if int(club["titles_won"]) >= min_titles]
    return filtered_clubs

@app.get("/clubs/fun-fact")
def get_fun_fact(club_name: str):
    from .utils import get_fun_fact
    return {"fun_fact": get_fun_fact(club_name)}