FROM python:3.12-slim

# 🧰 Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    libpq-dev \
    gcc \
    && apt-get clean

# 🔧 Set working directory
WORKDIR /app

# 🐍 Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:$PATH"

# 📦 Copy project files
COPY . .

# 📌 Use correct Python version in poetry
RUN poetry env use python3.12

# 📦 Install Python dependencies
RUN poetry install --no-interaction --no-ansi

# ✅ CLI agent startup command (no need for FastAPI)
CMD ["poetry", "run", "python", "-m", "openhands.cli.main"]