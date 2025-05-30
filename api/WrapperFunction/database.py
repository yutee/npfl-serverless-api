# Cosmos DB connection and queries

from azure.cosmos import CosmosClient
from .config import settings

class CosmosDB:
    """class to handle cosmosdb connection and queries"""
    def __init__(self):
        self.client = CosmosClient(settings.cosmos_endpoint, settings.cosmos_key)
        self.database = self.client.get_database_client(settings.cosmos_database)
        self.container = self.database.get_container_client(settings.cosmos_container)

    def get_clubs(self):
        query = """
        SELECT 
            c.id, 
            c.club, 
            c.full_name, 
            c.short_name, 
            c.nickname, 
            c.stadium, 
            c.titles_won, 
            c.logo
        FROM c
        """
        try:
            items = list(self.container.query_items(query, enable_cross_partition_query=True))
            return items
        except Exception:
            return {"Internal Server Error"}