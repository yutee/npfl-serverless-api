# Configuration settings (e.g., environment variables) - load environment variables from a .env file here, should contain details for database connection

from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    cosmos_endpoint: str
    cosmos_key: str
    cosmos_database: str
    cosmos_container: str

    class Config:
        env_file = ".env"

settings = Settings()