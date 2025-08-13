# LMS-DB
The schema code for the database and tables to be used by the LMS system


## Required Files
### ./.env
The environment variables file with the following variables:
```
DB_NAME
DB_USER
DB_PASSWORD
```

## How to run
1) Create a virtual environment (Optional best practice)
```python
python -m venv <path>
```

2) Acitvate the virtual environment
Mac:
```bash
source <path>/bin/activate
```

Windows:
```cmd
<path>\Scripts\activate.bat
```
```powershell
<path>\Scripts\Activate.ps1
```

2) Use Pip to install all required packages (Only required on first run)
```python
pip install -r requirements
```

3) Run the application
```python
python ./src/database_creation.py
```