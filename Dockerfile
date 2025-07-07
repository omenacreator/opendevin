FROM python:3.12-slim

# System-level dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    libpq-dev \
    gcc \
    && apt-get clean

# Set work directory
WORKDIR /app

# Install poetry
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:$PATH"

# Copy source
COPY . .

# Use project’s correct Python version
RUN poetry env use python3.12

# Install dependencies
RUN poetry install --no-interaction --no-ansi

EXPOSE 3000

# Start the agent
CMD ["poetry", "run", "python", "-m", "openhands"]