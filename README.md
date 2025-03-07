# NPFL Clubs API

## Overview
This API provides information about NPFL clubs. Developed with FastAPI, Azure Cosmos DB and Azure Storage and deployed using Azure Function App.
See a short demo video of the setup process and features [here](link.com).

## Endpoints
- `GET /clubs`: Get all clubs.
- `GET /clubs/by-titles?min_titles=5`: Get clubs with at least 5 titles.
- `GET /clubs/fun-fact?club_name=Enyimba`: Get a fun fact about a club.

## Local Setup
1. Provision Infrastructure using terraform in the `infra` directory.
2. Fill database with `data.json` data.
3. Update `api/.env` file with credentials.
4. Install dependencies: `pip install -r requirements.txt`.
5. Run the app: `uvicorn app.main:app --reload`.

## Cloud Setup
1. Do 1-3 of Local Setup
2. Install Azure Core Tools (Func)
3. Create Azure Function App
4. Run

OR,
Run the `script.sh` script.