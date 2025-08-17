-- Create the database (safe if it already exists)
CREATE DATABASE IF NOT EXISTS alx_book_store;

-- Use the database
USE alx_book_store;

-- AUTHORS
CREATE TABLE IF NOT EXISTS Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(215) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- CUSTOMERS
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(215) NOT NULL,
    email VARCHAR(215) NOT NULL,
    address TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- BOOKS
CREATE TABLE IF NOT EXISTS Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(130) NOT NULL,
    author_id INT NOT NULL,
    price DOUBLE NOT NULL,
    publication_date DATE,
    CONSTRAINT fk_books_author
        FOREIGN KEY (author_id)
        REFERENCES Authors(author_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    INDEX idx_books_author_id (author_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ORDERS
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ORDER_DETAILS
CREATE TABLE IF NOT EXISTS Order_Details (
    orderdetailid INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity DOUBLE NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
