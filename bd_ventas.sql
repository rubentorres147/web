	-- Crear la base de datos
CREATE DATABASE bd_ventas;
USE bd_ventas;
-- 1. Crear la tabla de control de secuencias
		CREATE TABLE secuencias (
			tabla VARCHAR(20) PRIMARY KEY,
			ultimo_valor INT NOT NULL
		);
-- 2. Crear las tablas principales con datos iniciales:
	-- 2.1 Tabla: productos.
		CREATE TABLE productos (
			id_producto VARCHAR(10) PRIMARY KEY,
			nombre_producto VARCHAR(100) NOT NULL,
			descripcion_producto TEXT,
			precio DECIMAL(10, 2) NOT NULL,
			stock_actual INT NOT NULL DEFAULT 0,
			fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
		);
	-- 2.2 Tabla: clientes.
		CREATE TABLE clientes (
			id_cliente VARCHAR(10) PRIMARY KEY,
			nombre_cliente VARCHAR(100) NOT NULL,
			direccion_cliente VARCHAR(150),
			telefono_cliente VARCHAR(15),
			email_cliente VARCHAR(100),
			fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
		);
	-- 2.3 Tabla: ventas.
		CREATE TABLE ventas (
			id_venta VARCHAR(10) PRIMARY KEY,
			id_cliente VARCHAR(10),
			fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
			total DECIMAL(10, 2) NOT NULL,
			FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
		);
	-- 2.4 Tabla: detalle_ventas.
		CREATE TABLE detalle_ventas (
			id_detalle_venta INT AUTO_INCREMENT PRIMARY KEY,
			id_venta VARCHAR(10),
			id_producto VARCHAR(10),
			cantidad INT NOT NULL,
			precio_unitario DECIMAL(10, 2) NOT NULL,
			subtotal DECIMAL(10, 2) NOT NULL,
			FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
			FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
		);
	-- 2.5 Tabla: proveedores.
		CREATE TABLE proveedores (
			id_proveedor VARCHAR(10) PRIMARY KEY,
			nombre_proveedor VARCHAR(100) NOT NULL,
			direccion_proveedor VARCHAR(150),
			telefono_proveedor VARCHAR(15),
			email_proveedor VARCHAR(100),
			fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
		);
	-- 2.6 Tabla: compras.
		CREATE TABLE compras (
			id_compra VARCHAR(10) PRIMARY KEY,
			id_proveedor VARCHAR(10),
			fecha_compra TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
			total_compra DECIMAL(10, 2) NOT NULL,
			FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
		);
	-- 2.7 Tabla: detalle_compras.
		CREATE TABLE detalle_compras (
			id_detalle_compra INT AUTO_INCREMENT PRIMARY KEY,
			id_compra VARCHAR(10),
			id_producto VARCHAR(10),
			cantidad INT NOT NULL,
			precio_unitario DECIMAL(10, 2) NOT NULL,
			subtotal DECIMAL(10, 2) NOT NULL,
			FOREIGN KEY (id_compra) REFERENCES compras(id_compra),
			FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
		);
	-- 2.8 Tabla: movimientos_inventario (Cardex).
		CREATE TABLE movimientos_inventario (
			id_movimiento INT AUTO_INCREMENT PRIMARY KEY,
			id_producto VARCHAR(10),
			tipo_movimiento ENUM('entrada', 'salida') NOT NULL,
			cantidad INT NOT NULL,
			fecha_movimiento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
			comentario TEXT,
			FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
		);

-- 3. Crear los triggers para autogenerar los IDs
	-- Trigger para la tabla productos
		DELIMITER $$
		CREATE TRIGGER tr_producto_id BEFORE INSERT ON productos
		FOR EACH ROW
		BEGIN
			DECLARE nuevo_id VARCHAR(10);
			UPDATE secuencias SET ultimo_valor = ultimo_valor + 1 WHERE tabla = 'productos';
			SELECT LPAD(ultimo_valor, 6, '0') INTO nuevo_id FROM secuencias WHERE tabla = 'productos';
			SET NEW.id_producto = CONCAT('P', nuevo_id);
		END$$
		DELIMITER ;
    -- Trigger para la tabla clientes
		DELIMITER $$
		CREATE TRIGGER tr_cliente_id BEFORE INSERT ON clientes
		FOR EACH ROW
		BEGIN
			DECLARE nuevo_id VARCHAR(10);
			UPDATE secuencias SET ultimo_valor = ultimo_valor + 1 WHERE tabla = 'clientes';
			SELECT LPAD(ultimo_valor, 6, '0') INTO nuevo_id FROM secuencias WHERE tabla = 'clientes';
			SET NEW.id_cliente = CONCAT('C', nuevo_id);
		END$$
		DELIMITER ;
    -- Trigger para la tabla ventas
		DELIMITER $$
		CREATE TRIGGER tr_venta_id BEFORE INSERT ON ventas
		FOR EACH ROW
		BEGIN
			DECLARE nuevo_id VARCHAR(10);
			UPDATE secuencias SET ultimo_valor = ultimo_valor + 1 WHERE tabla = 'ventas';
			SELECT LPAD(ultimo_valor, 6, '0') INTO nuevo_id FROM secuencias WHERE tabla = 'ventas';
			SET NEW.id_venta = CONCAT('V', nuevo_id);
		END$$
		DELIMITER ;
    -- Trigger para la tabla proveedores
		DELIMITER $$
		CREATE TRIGGER tr_proveedor_id BEFORE INSERT ON proveedores
		FOR EACH ROW
		BEGIN
			DECLARE nuevo_id VARCHAR(10);
			UPDATE secuencias SET ultimo_valor = ultimo_valor + 1 WHERE tabla = 'proveedores';
			SELECT LPAD(ultimo_valor, 6, '0') INTO nuevo_id FROM secuencias WHERE tabla = 'proveedores';
			SET NEW.id_proveedor = CONCAT('PR', nuevo_id);
		END$$
		DELIMITER ;
    -- Trigger para la tabla compras
		DELIMITER $$
		CREATE TRIGGER tr_compra_id BEFORE INSERT ON compras
		FOR EACH ROW
		BEGIN
			DECLARE nuevo_id VARCHAR(10);
			UPDATE secuencias SET ultimo_valor = ultimo_valor + 1 WHERE tabla = 'compras';
			SELECT LPAD(ultimo_valor, 6, '0') INTO nuevo_id FROM secuencias WHERE tabla = 'compras';
			SET NEW.id_compra = CONCAT('CO', nuevo_id);
		END$$
		DELIMITER ;

-- 4. Insertar valores iniciales para las secuencias de cada tabla
        -- 4.1 Tabla: secuencias
            INSERT INTO secuencias (tabla, ultimo_valor) VALUES ('productos', 0);
            INSERT INTO secuencias (tabla, ultimo_valor) VALUES ('clientes', 0);
            INSERT INTO secuencias (tabla, ultimo_valor) VALUES ('ventas', 0);
            INSERT INTO secuencias (tabla, ultimo_valor) VALUES ('proveedores', 0);
            INSERT INTO secuencias (tabla, ultimo_valor) VALUES ('compras', 0);
        -- 4.2 Tabla: productos
            INSERT INTO productos (nombre_producto, descripcion_producto, precio, stock_actual) 
            VALUES 
                ('Laptop Dell Inspiron 15', 'Laptop Dell con procesador Intel Core i7', 800.00, 50),
                ('Teclado Mecánico', 'Teclado mecánico RGB con switches Cherry MX', 120.00, 150),
                ('Mouse Inalámbrico', 'Mouse óptico inalámbrico', 25.00, 200);
        -- 4.3 Tabla: clientes
            INSERT INTO clientes (nombre_cliente, direccion_cliente, telefono_cliente, email_cliente) 
            VALUES 
                ('Juan Perez', 'Calle 123', '123456789', 'juan.perez@example.com'),
                ('Maria Lopez', 'Av. Las Flores 456', '987654321', 'maria.lopez@example.com'),
                ('Carlos Ramirez', 'Jr. El Sol 789', '987654123', 'carlos.ramirez@example.com');
        -- 4.4 Tabla: ventas
            INSERT INTO ventas (id_cliente, total) 
            VALUES 
                ('C000001', 925.00),
                ('C000002', 45.00),
                ('C000003', 800.00);           
		-- 4.5 Tabla: detalle_ventas 
            INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unitario, subtotal) 
            VALUES 
                ('V000001', 'P000001', 1, 800.00, 800.00),
                ('V000001', 'P000002', 1, 120.00, 120.00),
                ('V000002', 'P000003', 2, 25.00, 50.00),
                ('V000003', 'P000001', 1, 800.00, 800.00);    
        -- 4.6 Tabla: proveedores
            INSERT INTO proveedores (nombre_proveedor, direccion_proveedor, telefono_proveedor, email_proveedor) 
            VALUES 
                ('Proveedor Tech', 'Calle 123', '555123456', 'info@tech.com'),
                ('Suministros XYZ', 'Av. Principal 789', '555987654', 'contacto@xyz.com'),
                ('Electronica Perez', 'Jr. La Union 456', '555321987', 'ventas@perez.com');
        -- 4.7 Tabla: compras
            INSERT INTO compras (id_proveedor, total_compra) 
            VALUES 
                ('PR000001', 1000.00),
                ('PR000002', 500.00),
                ('PR000003', 1200.00);
        -- 4.8 Tabla: detalle_compras
            INSERT INTO detalle_compras (id_compra, id_producto, cantidad, precio_unitario, subtotal) 
            VALUES 
                ('CO000001', 'P000001', 5, 800.00, 4000.00),
                ('CO000002', 'P000002', 20, 100.00, 2000.00),
                ('CO000003', 'P000003', 50, 20.00, 1000.00);
        -- 4.9 Tabla: movimientos_inventario
            INSERT INTO movimientos_inventario (id_producto, tipo_movimiento, cantidad, comentario) 
            VALUES 
                ('P000001', 'entrada', 5, 'Compra a Proveedor Tech'),
                ('P000001', 'salida', 1, 'Venta a Juan Perez'),
                ('P000002', 'entrada', 20, 'Compra a Suministros XYZ'),
                ('P000002', 'salida', 1, 'Venta a Juan Perez'),
                ('P000003', 'entrada', 50, 'Compra a Electronica Perez'),
                ('P000003', 'salida', 2, 'Venta a Maria Lopez');
