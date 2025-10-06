# security_config.py
from fastapi.security.api_key import APIKeyHeader

# Clave secreta que usaremos para autenticar
API_KEY = "mi_clave_secreta_12345"

# Nombre del header donde el cliente enviará la clave
API_KEY_NAME = "x-api-key"

# Configuración para buscar la API Key en los headers
api_key_header = APIKeyHeader(name=API_KEY_NAME, auto_error=False)