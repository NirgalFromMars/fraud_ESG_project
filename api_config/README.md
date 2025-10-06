# API Configuration Folder

This folder contains all configuration and auxiliary files related to the API developed in the **Fraud vs. ESG** project. These files support the main API logic implemented in the notebook `API.ipynb`.

---

## 📁 Files Overview

### 1. `api.log`

* **Purpose:** Stores execution logs generated during API runtime.
* **Content:** Information messages, errors, and warnings captured through Python’s `logging` module.
* **Usage:** Useful for debugging and tracking API activity. The log file is created automatically when the API starts.

### 2. `openapi.json`

* **Purpose:** Defines the OpenAPI (Swagger) schema for the API.
* **Content:** Automatically generated documentation describing endpoints, parameters, and response structures.
* **Usage:** Can be imported into tools like Swagger UI, Postman, or other API testing environments for interactive documentation and testing.

### 3. `security_config.py`

* **Purpose:** Manages API security configuration and authentication logic.
* **Content:** May include API keys, token validation logic, and CORS (Cross-Origin Resource Sharing) rules.
* **Usage:** Imported by the main notebook to ensure secure access and consistent configuration across endpoints.

---

## 🔗 Relation with the API Notebook

All three files are **interconnected** and complement the main API code:

* `api.log` → runtime logging
* `openapi.json` → documentation schema
* `security_config.py` → authentication and security policies

Together, they ensure that the API is **documented**, **secure**, and **traceable** t
