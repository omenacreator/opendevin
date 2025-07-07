FROM python:3.12-slim

WORKDIR /app

COPY . .

RUN pip install --upgrade pip && \
    pip install poetry && \
    poetry config virtualenvs.create false && \
    poetry install --no-dev --no-interaction

EXPOSE 3000

CMD ["poetry", "run", "python", "-m", "openhands"]
