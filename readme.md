# Práctica de fragmentación de base de datos distribuida

Este proyecto corresponde a una práctica de fragmentación de base de datos distribuida usando PostgreSQL en contenedores Docker. El escenario utilizado es una cafetería universitaria con tres nodos: Campus, Babahoyo y Ventanas.

El objetivo principal es aplicar fragmentación horizontal, vertical y mixta sobre una base de datos sencilla, y luego comprobar que los fragmentos cumplen las reglas de completitud, reconstrucción y disjunción.

## Estructura del proyecto

```text
practica-fragmentacion/
│
├── docker-compose.yml
└── sql/
    ├── 01_esquema_central.sql
    ├── 02_datos.sql
    ├── 03_fragmentacion_horizontal_campus.sql
    ├── 03_fragmentacion_horizontal_babahoyo.sql
    ├── 03_fragmentacion_horizontal_ventanas.sql
    ├── 04_fragmentacion_vertical_campus.sql
    ├── 04_fragmentacion_vertical_babahoyo.sql
    ├── 05_fragmentacion_mixta.sql
    ├── 05a_mixta_campus.sql
    ├── 05b_mixta_babahoyo.sql
    ├── 05c_mixta_ventanas.sql
    ├── 06_vistas_globales.sql
    └── 07_verificacion.sql
```

El archivo `05_fragmentacion_mixta.sql` se conserva como archivo general para cumplir con la estructura solicitada en la guía. Para la ejecución real se usan los archivos separados `05a`, `05b` y `05c`, ya que cada bloque de la fragmentación mixta corresponde a un nodo diferente.

## Requisitos

Antes de ejecutar la práctica se necesita tener instalado:

- Docker Desktop.
- PowerShell o una terminal compatible.
- Un editor de código, por ejemplo IntelliJ IDEA o Visual Studio Code.

## Levantar los contenedores

Desde la carpeta raíz del proyecto ejecutar:

```powershell
docker compose up -d
```

Para verificar que los contenedores están en ejecución:

```powershell
docker compose ps
```

Deben aparecer tres contenedores activos:

```text
pg-campus
pg-babahoyo
pg-ventanas
```

## Ejecución de scripts SQL

En PowerShell no se usa el operador `<` para redireccionar archivos SQL. Por eso se utiliza `Get-Content` junto con `docker exec`.

### 1. Crear esquema centralizado y cargar datos

Estos scripts se ejecutan en el nodo `pg-campus`, que funciona como nodo central de referencia.

```powershell
Get-Content .\sql\01_esquema_central.sql | docker exec -i pg-campus psql -U admin -d cafeteria
Get-Content .\sql\02_datos.sql | docker exec -i pg-campus psql -U admin -d cafeteria
```

### 2. Fragmentación horizontal

La fragmentación horizontal se aplica sobre la tabla `pedidos`, usando la columna `sede`. Cada nodo recibe únicamente los pedidos que corresponden a su sede.

```powershell
Get-Content .\sql\03_fragmentacion_horizontal_campus.sql | docker exec -i pg-campus psql -U admin -d cafeteria
Get-Content .\sql\03_fragmentacion_horizontal_babahoyo.sql | docker exec -i pg-babahoyo psql -U admin -d cafeteria
Get-Content .\sql\03_fragmentacion_horizontal_ventanas.sql | docker exec -i pg-ventanas psql -U admin -d cafeteria
```

### 3. Fragmentación vertical

La fragmentación vertical se aplica sobre la tabla `clientes`. Los datos públicos se almacenan en `pg-campus` y los datos de contacto en `pg-babahoyo`.

```powershell
Get-Content .\sql\04_fragmentacion_vertical_campus.sql | docker exec -i pg-campus psql -U admin -d cafeteria
Get-Content .\sql\04_fragmentacion_vertical_babahoyo.sql | docker exec -i pg-babahoyo psql -U admin -d cafeteria
```

### 4. Fragmentación mixta

La fragmentación mixta combina fragmentación horizontal y vertical sobre la tabla `clientes`. Primero se separan los clientes por ciudad y luego por tipo de dato.

```powershell
Get-Content .\sql\05a_mixta_campus.sql | docker exec -i pg-campus psql -U admin -d cafeteria
Get-Content .\sql\05b_mixta_babahoyo.sql | docker exec -i pg-babahoyo psql -U admin -d cafeteria
Get-Content .\sql\05c_mixta_ventanas.sql | docker exec -i pg-ventanas psql -U admin -d cafeteria
```

### 5. Vistas globales

Las vistas globales se crean desde el nodo `pg-campus`. Se usa `postgres_fdw` para consultar tablas ubicadas en los otros nodos.

```powershell
Get-Content .\sql\06_vistas_globales.sql | docker exec -i pg-campus psql -U admin -d cafeteria
```

Este script debe crear las vistas:

```text
pedidos_global
clientes_global
```

### 6. Verificación

El script de verificación comprueba las tres condiciones principales de una fragmentación correcta: completitud, reconstrucción y disjunción.

```powershell
Get-Content .\sql\07_verificacion.sql | docker exec -i pg-campus psql -U admin -d cafeteria
```

## Consultas de comprobación manual

Para entrar al nodo `pg-campus`:

```powershell
docker exec -it pg-campus psql -U admin -d cafeteria
```

Dentro de `psql`, verificar las vistas:

```sql
\dv
```

Consultar los pedidos reconstruidos:

```sql
SELECT * FROM pedidos_global;
```

Consultar los clientes reconstruidos:

```sql
SELECT * FROM clientes_global;
```

Comprobar completitud:

```sql
SELECT COUNT(*) AS filas_globales
FROM pedidos_global;
```

El resultado esperado es:

```text
8
```

Comprobar reconstrucción por sede:

```sql
SELECT sede, SUM(monto)
FROM pedidos_global
GROUP BY sede;
```

El resultado esperado es:

```text
Babahoyo | 4.25
Campus   | 4.25
Ventanas | 2.25
```

Comprobar disjunción:

```sql
SELECT pedido_id, COUNT(*) AS veces
FROM pedidos_global
GROUP BY pedido_id
HAVING COUNT(*) > 1;
```

El resultado esperado es:

```text
0 rows
```

Esto significa que ningún pedido fue insertado en más de un nodo.

## Descripción de los nodos

| Nodo | Contenedor | Puerto local | Función |
|---|---|---:|---|
| Campus | `pg-campus` | 5433 | Nodo principal y sede Campus |
| Babahoyo | `pg-babahoyo` | 5434 | Nodo de sede Babahoyo |
| Ventanas | `pg-ventanas` | 5435 | Nodo de sede Ventanas |

## Resumen de fragmentación

### Fragmentación horizontal

Se aplicó sobre `pedidos` usando la columna `sede`.

- `pg-campus`: pedidos de Campus.
- `pg-babahoyo`: pedidos de Babahoyo.
- `pg-ventanas`: pedidos de Ventanas.

### Fragmentación vertical

Se aplicó sobre `clientes`.

- `clientes_publicos`: `cliente_id`, `nombre`, `ciudad`.
- `clientes_contacto`: `cliente_id`, `email`, `telefono`.

La clave primaria `cliente_id` se conserva en ambos fragmentos para poder reconstruir la tabla mediante `JOIN`.

### Fragmentación mixta

Se aplicó también sobre `clientes` combinando ciudad y sensibilidad del dato.

- `pg-campus`: clientes de Quevedo con datos públicos.
- `pg-babahoyo`: datos de contacto.
- `pg-ventanas`: clientes de Babahoyo y Ventanas con datos públicos.

## Apagar los contenedores

Para detener los contenedores:

```powershell
docker compose down
```

Para eliminar también los volúmenes y reiniciar la práctica desde cero:

```powershell
docker compose down -v
```

## Observación

Si se vuelve a ejecutar un script que ya creó tablas, vistas o servidores remotos, pueden aparecer mensajes como `already exists`. En ese caso, se debe revisar si el script contiene instrucciones `DROP TABLE IF EXISTS`, `DROP VIEW IF EXISTS` o si se necesita limpiar la base con `docker compose down -v` antes de repetir toda la práctica.
