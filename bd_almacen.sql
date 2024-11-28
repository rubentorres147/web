-- De una sola tabla
CREATE DATABASE almacen_db;

USE almacen_db;

CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    cantidad INT NOT NULL
);
-- De Dos tablas
CREATE DATABASE almacen;

USE almacen;

CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE proveedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono varchar(100) NOT NULL,
    email varchar(100) NOT NULL
);

DROP TABLE productos

CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2),
    stock int,
    id_categoria INT,
    id_proveedor int,
    FOREIGN KEY (id_categoria) REFERENCES categorias (id),
    FOREIGN KEY (id_proveedor) REFERENCES proveedores (id)
);