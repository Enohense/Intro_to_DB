#!/usr/bin/env python3
# MySQLServer.py
# Creates the 'alx_book_store' database on a MySQL server.
# - Prints a success message when created (or already present).
# - Prints a clear error message if connection or creation fails.
# - Safely opens/closes the DB connection.
# - Avoids any read-only query statements.

import os
import sys
import mysql.connector
from mysql.connector import errorcode

DB_NAME = "alx_book_store"

def get_connection():
    """
    Builds a server-level connection (no default DB chosen)
    using environment variables or sensible defaults.
    """
    cfg = {
        "host": os.getenv("MYSQL_HOST", "localhost"),
        "user": os.getenv("MYSQL_USER", "root"),
        "password": os.getenv("MYSQL_PASSWORD", "Good911_HELPER"),
        "port": int(os.getenv("MYSQL_PORT", "3306")),
    }
    return mysql.connector.connect(**cfg)

def create_database(cursor):
    """
    Creates the database if it does not already exist.
    Uses IF NOT EXISTS to keep it idempotent.
    """
    cursor.execute("CREATE DATABASE IF NOT EXISTS alx_book_store")

def main():
    conn = None
    try:
        conn = get_connection()
        conn.autocommit = True  # ensure DDL commits automatically
        cursor = conn.cursor()
        create_database(cursor)
        print(f"Database '{DB_NAME}' created successfully!")
    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("Error: Access denied. Check your MySQL username/password.")
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("Error: The specified database does not exist.")
        else:
            print(f"Error: {err}")
        sys.exit(1)
    except Exception as ex:
        print(f"Unexpected error: {ex}")
        sys.exit(1)
    finally:
        if conn is not None and conn.is_connected():
            conn.close()

if __name__ == "__main__":
    main()
