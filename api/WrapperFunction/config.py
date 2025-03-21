# configuration settings (e.g., environment variables) - load environment variables from a .env file here, should contain details for database connection

from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    """class to handle loading environment variables"""
    cosmos_endpoint: str
    cosmos_key: str
    cosmos_database: str
    cosmos_container: str

    openai_api_key: str

    class Config:
        env_file = ".env"

settings = Settings()