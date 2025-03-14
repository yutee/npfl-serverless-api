# utility functions - interacting with openai api
from openai import OpenAI
from .config import settings

client = OpenAI(api_key=settings.openai_api_key)

def openai_fun_fact(club_name: str):
    try:
        response = client.chat.completions.create(
        model="gpt-4o-mini",
        messages=[{
                    "role": "user",
                    "content": f"Tell me a fun fact about {club_name}"
                }]
        )
        return response.choices[0].message.content
    except Exception as e:
        return {"An error occurred: Unable to reach OpenAI API."}
    
    
