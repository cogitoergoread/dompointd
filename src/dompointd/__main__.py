import uvicorn
from dompointd.api import app

def main():
    uvicorn.run(app)

if __name__ == "__main__":
    main()
