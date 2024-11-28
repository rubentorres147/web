# Guía de Proyecto MVC
### Productos de una sola tabla

Este proyecto implementa un sistema básico de gestión de productos utilizando el patrón **MVC (Modelo-Vista-Controlador)**.

## Tabla de Contenidos
- [Guía de Proyecto MVC](#guía-de-proyecto-mvc)
    - [Productos de una sola tabla](#productos-de-una-sola-tabla)
  - [Tabla de Contenidos](#tabla-de-contenidos)
  - [Paso 1: Configuración de la Base de Datos](#paso-1-configuración-de-la-base-de-datos)
  - [Paso 2: Estructura del Proyecto](#paso-2-estructura-del-proyecto)
  - [Paso 3: Controlador de Productos](#paso-3-controlador-de-productos)
  - [Paso 4: Modelo de Producto](#paso-4-modelo-de-producto)
  - [Paso 5: Vistas (Views)](#paso-5-vistas-views)
  - [Paso 6: Configuración de la Base de Datos](#paso-6-configuración-de-la-base-de-datos)
  - [Paso 7: Archivo Principal del Proyecto](#paso-7-archivo-principal-del-proyecto)

---

## Paso 1: Configuración de la Base de Datos

Primero, necesitamos crear la base de datos y la tabla que almacenará los productos.

```sql
CREATE DATABASE almacen_db;
USE almacen_db;
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    cantidad INT NOT NULL
);
```
>**Explicación:**
>- **id:** Identificador único de cada producto.
>- **nombre:** Nombre del producto.
>- **precio:** Precio del producto.
>- **cantidad:** Cantidad disponible en el inventario.

## Paso 2: Estructura del Proyecto
La estructura de un proyecto MVC en este caso se puede organizar de la siguiente manera:
```
/almacen/
│
├── /app/
│   ├── /controllers/
│   │   └── ProductosController.php
│   ├── /models/
│   │   └── Producto.php
│   └── /views/
│       ├──/assets/
│       │   ├──/CSS/
│       │   ├──/fonts/
│       │   ├──/images/
│       │   ├──/js/
│       │   ├──/vendor/
│       │   └──/vendor/
│       ├──/layouts/
│       │   ├── footer.php
│       │   ├── header.php
│       │   └── sidebar.php
│       └──/productos/
│           ├── create.php
│           ├── edit.php
│           ├── index.php
│           └── search.php
├── /config/
│   └── database.php
│
├── /public/
│   └── index.php
└── .htaccess
```
>**Descripción:**
>- **Controladores (/controllers):** Contienen la lógica de negocio, como la creación, edición, y eliminación de productos.
>- **Modelos (/models):** Manejan la interacción con la base de datos.
>- **Vistas (/views):** Son las páginas HTML que verá el usuario.
>- **Configuraciones (/config):** Archivos de configuración, como la conexión a la base de datos.
>- **Carpeta (/layouts):** contiene los archivos de plantilla que definen la estructura básica de las páginas en la aplicación. Esta organización permite una separación clara de las diferentes secciones de la interfaz de usuario.
>   - **footer.php:** Contiene el pie de página común a todas las páginas.
>   - **header.php:** Define la cabecera de la aplicación, que incluye el menú de navegación y el título.
>   - **sidebar.php:** Proporciona la barra lateral con enlaces adicionales y opciones de navegación.




## Paso 3: Controlador de Productos
El Controlador es el encargado de procesar las solicitudes del usuario, ya sea para listar, crear, actualizar o eliminar productos.

``` php
<?php
// app/controllers/ProductosController.php

require_once '../config/database.php';
require_once '../app/models/Producto.php';

class ProductosController {
    private $productoModel;

    public function __construct() {
        global $conn;
        $this->productoModel = new Producto($conn);
    }

    // Listar productos
    public function listar() {
        $productos = $this->productoModel->listar();
        require '../app/views/productos/index.php';
    }

    // Crear producto
    public function crear() {
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $nombre = $_POST['nombre'];
            $precio = $_POST['precio'];
            $cantidad = $_POST['cantidad'];

            if ($this->productoModel->crear($nombre, $precio, $cantidad)) {
                header("Location: /almacen/public/index.php");
                exit();
            }
        }
        require '../app/views/productos/create.php';
    }

    // Actualizar producto
    public function actualizar($id) {
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $nombre = $_POST['nombre'];
            $precio = $_POST['precio'];
            $cantidad = $_POST['cantidad'];

            if ($this->productoModel->actualizar($id, $nombre, $precio, $cantidad)) {
                header("Location: /almacen/public/index.php");
                exit();
            }
        } else {
            $producto = $this->productoModel->obtenerPorId($id);
            require '../app/views/productos/edit.php';
        }
    }

    // Eliminar producto
    public function eliminar($id) {
        if ($this->productoModel->eliminar($id)) {
            header("Location: /almacen/public/index.php");
            exit();
        }
    }
}
?>
```
> **Explicación:**
>- El controlador maneja las operaciones **CRUD:** crear, leer, actualizar y eliminar productos.
>- Cada método (*listar*, *crear*, *actualizar*, *eliminar*) ejecuta una acción correspondiente.

## Paso 4: Modelo de Producto
El Modelo gestiona la interacción con la base de datos.
``` php
<?php
// app/models/Producto.php
class Producto {
    private $conn;
    public function __construct($db) {
        $this->conn = $db;
    }
    // Crear producto
    public function crear($nombre, $precio, $cantidad) {
        $sql = "INSERT INTO productos (nombre, precio, cantidad) VALUES (:nombre, :precio, :cantidad)";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':nombre', $nombre);
        $stmt->bindParam(':precio', $precio);
        $stmt->bindParam(':cantidad', $cantidad);

        return $stmt->execute();
    }

    // Listar todos los productos
    public function listar() {
        $query = "SELECT * FROM productos";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Obtener producto por ID
    public function obtenerPorId($id) {
        $query = "SELECT * FROM productos WHERE id = :id";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // Actualizar producto
    public function actualizar($id, $nombre, $precio, $cantidad) {
        $query = "UPDATE productos SET nombre = :nombre, precio = :precio, cantidad = :cantidad WHERE id = :id";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':nombre', $nombre);
        $stmt->bindParam(':precio', $precio);
        $stmt->bindParam(':cantidad', $cantidad);
        $stmt->bindParam(':id', $id);
        return $stmt->execute();
    }

    // Eliminar producto
    public function eliminar($id) {
        $query = "DELETE FROM productos WHERE id = :id";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':id', $id);
        return $stmt->execute();
    }
}
?>
```

>**Explicación:**
>- El modelo interactúa directamente con la base de datos utilizando PDO para manejar los datos de los productos.



## Paso 5: Vistas (Views)
Las Vistas son las páginas que el usuario ve y con las que interactúa. A continuación se muestran ejemplos de la vista de creación y la vista de listado de productos.
**Vista para Crear Producto (create.php)**
```php
<form action="/almacen/public/index.php?controller=productos&action=crear" method="POST">
    <label for="nombre">Nombre:</label>
    <input type="text" name="nombre" required>
    
    <label for="precio">Precio:</label>
    <input type="text" name="precio" required>
    
    <label for="cantidad">Cantidad:</label>
    <input type="number" name="cantidad" required>
    
    <button type="submit">Crear</button>
</form>
```

**Vista para Listar Productos (index.php)**
```php
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Precio</th>
            <th>Cantidad</th>
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach ($productos as $producto): ?>
            <tr>
                <td><?php echo $producto['id']; ?></td>
                <td><?php echo $producto['nombre']; ?></td>
                <td><?php echo $producto['precio']; ?></td>
                <td><?php echo $producto['cantidad']; ?></td>
                <td>
                    <a href="/almacen/public/index.php?controller=productos&action=actualizar&id=<?php echo $producto['id']; ?>">Editar</a>
                    <a href="/almacen/public/index.php?controller=productos&action=eliminar&id=<?php echo $producto['id']; ?>">Eliminar</a>
                </td>
            </tr>
        <?php endforeach; ?>
    </tbody>
</table>
```

## Paso 6: Configuración de la Base de Datos
El archivo **database.php** gestiona la conexión con la base de datos.
```php
<?php
// config/database.php

$host = 'localhost';
$db_name = 'almacen_db';
$username = 'root';
$password = '';

try {
    $conn = new PDO("mysql:host=$host;dbname=$db_name", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    echo "Error en la conexión: " . $e->getMessage();
}
?>

```

## Paso 7: Archivo Principal del Proyecto
El archivo **index.php** en la carpeta **/public/** es el punto de entrada del proyecto.
```php
<?php
require_once '../app/controllers/ProductosController.php';

$controller = new ProductosController();
$action = isset($_GET['action']) ? $_GET['action'] : 'listar';

switch ($action) {
    case 'crear':
        $controller->crear();
        break;
    case 'actualizar':
        $id = $_GET['id'];
        $controller->actualizar($id);
        break;
    case 'eliminar':
        $id = $_GET['id'];
        $controller->eliminar($id);
        break;
    case 'listar':
    default:
        $controller->listar();
        break;
}
?>
```