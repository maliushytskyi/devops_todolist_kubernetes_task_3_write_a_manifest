FROM python:3.8-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Спочатку лише requirements, щоб кешувався шар з установкою залежностей
COPY src/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Весь код застосунку з src/ потрапляє в /app (там буде manage.py)
COPY src/ .

EXPOSE 8000

# Міграції при старті контейнера, потім запуск сервера
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]