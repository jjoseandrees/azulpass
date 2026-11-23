# Manual de Uso e Instalación — AzulPass

## 1. Requisitos del Sistema

### Entorno de Servidor (Back-End)
* **Sistema Operativo:** Linux (Ubuntu 22.04 LTS o superior), macOS Monterey o superior, Windows 10/11.
* **Entorno de Ejecución:** Node.js v18.x o v20.x LTS.
* **Base de Datos:** PostgreSQL v14.x o v16.x.
* **Administrador de paquetes:** `npm` v9.x o superior.

### Entorno de Cliente (Front-End)
* **Navegador Web:** Google Chrome, Mozilla Firefox o Microsoft Edge (últimas versiones).
* **Entorno Móvil (opcional):** Android 8.0 (API 26) o superior / iOS 14 o superior.

---

## 2. Guía de Instalación Paso a Paso

### Paso 1: Clonar el Repositorio
```bash
git clone https://github.com/jjoseandrees/azulpass.git
cd azulpass
```

### Paso 2: Configurar la Base de Datos PostgreSQL
1. Acceda a la consola de PostgreSQL:
   ```bash
   psql -U postgres
   ```
2. Cree la base de datos:
   ```sql
   CREATE DATABASE azulpass_db;
   \q
   ```
3. Ejecute el script SQL para crear el esquema e insertar los datos iniciales de prueba:
   ```bash
   psql -U postgres -d azulpass_db -f db/database.sql
   ```

### Paso 3: Configurar y Levantar el Back-End
1. Ingrese a la carpeta del proyecto back-end:
   ```bash
   cd azulpass-backend
   ```
2. Instale las dependencias de Node.js:
   ```bash
   npm install
   ```
3. Copie el archivo `.env.example` y renómbrelo a `.env`:
   ```bash
   cp .env.example .env
   ```
4. Abra `.env` con un editor de texto y asegúrese de definir los datos de conexión a PostgreSQL:
   ```env
   PORT=3000
   NODE_ENV=development
   DB_HOST=localhost
   DB_PORT=5432
   DB_NAME=azulpass_db
   DB_USER=postgres
   DB_PASSWORD=tu_password_postgres
   JWT_SECRET=super_secret_jwt_key_azulpass_2026
   ```
5. Inicie el servicio:
   ```bash
   npm run dev
   ```
   *Debería observar el mensaje: `Servidor corriendo en puerto 3000` y `Conexión a PostgreSQL exitosa`.*

### Paso 4: Levantar la Aplicación Flutter
1. En otra terminal, ingrese a la carpeta del cliente:
   ```bash
   cd azul_pass
   ```
2. Descargue los paquetes de Flutter:
   ```bash
   flutter pub get
   ```
3. Inicie la aplicación en modo Web:
   ```bash
   flutter run -d chrome
   ```

---

## 3. Manual de Uso para el Usuario Final

### 3.1 Exploración de Partidos Disponibles
1. Al abrir la aplicación, el usuario accede a la pantalla principal (**Home**), donde se visualiza la lista de próximos partidos.
2. Cada tarjeta indica los equipos enfrentados, fecha, hora, estadio y ciudad.
3. Al seleccionar un partido, la app realiza una petición `GET /api/matches/:id` para traer la lista actualizada de sectores con sus precios y stock de entradas disponibles.

### 3.2 Selección de Sector y Entradas
1. En la pantalla de **Detalle de Partido**, el usuario selecciona el sector deseado (ej. *Galería Sur* o *Andes*).
2. Selecciona la cantidad de entradas a comprar (máximo 4 entradas por transacción para evitar acaparamiento).
3. Presiona el botón **Continuar a Datos del Comprador**.

### 3.3 Registro del Comprador y Validación de RUT
1. Ingrese el RUT del comprador (ej. `12.345.678-5`).
2. El sistema aplica validación algorítmica por dígito verificador módulo 11. Si el RUT es inválido, la app no permite avanzar y muestra un mensaje de error claro en lenguaje de usuario.
3. Ingrese nombre completo, correo electrónico y teléfono de contacto.
4. Presiona **Confirmar y Pagar**.

### 3.4 Confirmación y Emisión de Entradas
1. El servidor ejecuta una transacción ACID con `SELECT ... FOR UPDATE` sobre la base de datos para descontar la disponibilidad de forma segura.
2. Al completarse, el usuario recibe en pantalla la confirmación con su **Código de Ticket** único (ej. `TCK-20261205-001-A8F2`).
3. La entrada queda guardada en la base de datos y se puede consultar en la sección **Mis Entradas**.

---

## 4. Solución a las 3 Fallas Más Frecuentes

### Falla 1: Error `ECONNREFUSED` al conectar con PostgreSQL
* **Síntoma:** El servidor Node.js finaliza inmediatamente tras ejecutar `npm run dev` indicando `Error: connect ECONNREFUSED 127.0.0.1:5432`.
* **Causa:** El servicio de PostgreSQL no se está ejecutando o el puerto 5432 está bloqueado.
* **Solución:**
  1. En Linux/Ubuntu, inicie el servicio con: `sudo systemctl start postgresql`.
  2. En Windows, abra `services.msc` y verifique que el servicio `postgresql-x64-14` esté en estado "En ejecución".
  3. Verifique en su `.env` que `DB_PORT=5432` y `DB_HOST=localhost`.

### Falla 2: Error `409 Conflict - No hay disponibilidad suficiente`
* **Síntoma:** Al presionar pagar, la aplicación muestra el mensaje *"El sector seleccionado no cuenta con stock suficiente"*.
* **Causa:** Las entradas disponibles (`available_tickets`) en la tabla `sectors` llegaron a 0 o son menores a la cantidad solicitada.
* **Solución:**
  1. Abra su consola psql y reinicie el stock del sector para pruebas:
     ```sql
     UPDATE sectors SET available_tickets = 100 WHERE id = 1;
     ```
  2. En el cliente, vuelva a seleccionar el partido para refrescar el estado del stock.

### Falla 3: El cliente Flutter no conecta con el Back-End local (`XMLHttpRequest error` en Web o `Connection Refused` en Android)
* **Síntoma:** La aplicación abre pero no carga partidos ni permite comprar.
* **Causa:** La URL base en `lib/core/constants/api_constants.dart` apunta a una dirección IP o túnel que no está activo.
* **Solución:**
  1. Para ejecución **Web (Chrome)**: asegúrese que `baseUrl` en `api_constants.dart` sea `http://localhost:3000/api`.
  2. Para ejecución en **Emulador Android**: cambie `baseUrl` a `http://10.0.2.2:3000/api` (ya que `10.0.2.2` mapea al localhost de la máquina anfitriona en el emulador oficial de Android).
  3. Recompilar o reiniciar el cliente Flutter con `R` (hot restart).