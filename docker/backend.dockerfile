
###STAGE BUILDER###
FROM python:3.12-slim AS builder
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    POETRY_VERSION=1.8.2
RUN pip install --no-cache-dir "poetry==$POETRY_VERSION" 
WORKDIR /app
COPY app/pyproject.toml app/poetry.lock* ./ 
RUN poetry export -f requirements.txt --output requirements.txt --without-hashes \
    && pip wheel --no-cache-dir --no-deps -r requirements.txt -w /wheels
COPY app/src ./src
###STAGE RUNTIME###
FROM python:3.12-slim AS runtime
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1
RUN addgroup --system app && adduser --system --ingroup app app
WORKDIR /app
COPY --from=builder /wheels /wheels
RUN pip install --no-cache-dir --no-warn-script-location /wheels/* \
 && rm -rf /wheels
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
 && rm -rf /var/lib/apt/lists/*
COPY app/src ./src    
COPY docker/entrypoint.sh ./entrypoint.sh
RUN chmod +x /app/entrypoint.sh \
 && chown -R app:app /app
USER app
ENV DEVELOPMENT=false 
EXPOSE 8080
ENTRYPOINT ["/app/entrypoint.sh"]

