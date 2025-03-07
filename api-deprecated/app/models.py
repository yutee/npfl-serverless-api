# Pydantic models for data validation

# models.py
from pydantic import BaseModel

class User(BaseModel):
    username: str
    email: str
    age: int


@app.post("/users/")
async def create_user(user: User):
    return {"username": user.username, "email": user.email}

# this will be expecting a POST request that should look like this:
# {
#     "username": "string",
#     "email": "string",
#     "age": 0
# }
# and will return a response that looks like this:
# {
#     "username": "string",
#     "email": "string"
# }
# If the request body is invalid, FastAPI will return a 422 Unprocessable Entity error with a detailed error message.


