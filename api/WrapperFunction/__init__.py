# FastAPI app and routes

from fastapi import FastAPI, HTTPException
from .database import CosmosDB

app = FastAPI()
db = CosmosDB()

@app.get("/")
def read_root():
    return {"message": "Welcome to the NPFL data API"}

@app.get("/clubs")
def get_clubs():
    try:
        return db.get_clubs()
    except Exception:
        raise HTTPException(status_code=500, detail="Internal Server Error")

@app.get("/clubs/{club_name}")
def get_club_by_name(club_name: str):
    # work on this endpoint, ensure input is validated and input is standardized to handle lowercase and uppercase inputs
    club_name = club_name.lower()
    clubs = db.get_clubs()
    club = next((club for club in clubs if club["club"].lower() == club_name), None)
    if club:
        return club, 200
    else:
        raise HTTPException(status_code=404, detail="Club not found")

@app.get("/clubs/by-titles-won")
def get_clubs_by_titles(min_titles: int):
    try:
        clubs = db.get_clubs()
        filtered_clubs = [club for club in clubs if int(club["titles_won"]) >= min_titles]
        return filtered_clubs
    except Exception:
        raise HTTPException(status_code=500, detail="Internal Server Error")

@app.get("/clubs/fun-fact")
def get_fun_fact(club_name: str):
    from .utils import get_fun_fact
    return {"fun_fact": get_fun_fact(club_name)}