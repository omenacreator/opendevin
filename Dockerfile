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

# Copy source code into the container
COPY . .

# (Optional) You can remove this line if it causes issues:
# RUN poetry env use python3.12

# Install dependencies
RUN poetry config virtualenvs.create false && \
    poetry install --no-interaction --no-ansi

# Expose port
EXPOSE 3000

# ✅ Corrected start command (no double CMD)
CMD ["poetry", "run", "uvicorn", "openhands.app.main:app", "--host", "0.0.0.0", "--port", "3000"]