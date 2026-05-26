FROM python:3.12-slim

RUN apt-get update && apt-get install -y curl

RUN useradd -m appuser

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PORT=8080

EXPOSE 8080

HEALTHCHECK CMD curl --fail http://localhost:8080/health || exit 1

USER appuser

CMD ["python", "api/app.py"]