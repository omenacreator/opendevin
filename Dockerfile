FROM python:3.12-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    libpq-dev \
    gcc \
    && apt-get clean

# Set work directory
WORKDIR /app

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:$PATH"

# Copy project files
COPY . .

# Use Python 3.12
RUN poetry env use python3.12

# Install dependencies
RUN poetry install --no-interaction --no-ansi

# Run CLI app
CMD ["poetry", "run", "python", "-m", "openhands.cli.main"]