# Utility functions (e.g., AI fun fact generation)

import openai

def get_fun_fact(club_name: str):
    response = openai.Completion.create(
        engine="text-davinci-003",
        prompt=f"Tell me a fun fact about {club_name}.",
        max_tokens=50
    )
    return response.choices[0].text.strip()