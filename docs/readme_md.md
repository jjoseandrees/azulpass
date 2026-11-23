# AzulPass — Plataforma Digital de Venta y Gestión de Entradas de Fútbol

> **Promesa de valor:** Para el hincha del fútbol chileno que sufre por la sobreventa de entradas, filas virtuales infinitas y revendedores, AzulPass entrega un sistema transparente de reserva y emisión de tickets con control de disponibilidad en tiempo real y verificación de identidad por RUT. Integrantes del Equipo (Azul Pass)

| Nombre completo | Usuario de GitHub | Rol principal | 
| ----- | ----- | ----- | 
| **García, José** | `@jjoseandrees` | Documentación y  QA | 
| **Oyarzún, Vicente** | `@VicenteO0709` | Desarrollo Front-End & Móvil, desarrollo Back-End & Base de Datos | 
|  |  | 

**Asignatura:** INGT1003 · Arquitectura de Desarrollo (Móvil y Web)

* **Carrera:** Escuela de Ingeniería Civil, Universidad Mayor

* **Docente:** Prof. Carlos Muñoz S.

* **Semestre:** Segundo Semestre 2026

##  Arquitectura del Sistema

AzulPass está construido bajo una **arquitectura por capas bien delimitada** (Monolito Modular en el servidor y Clean Architecture / Riverpod en la aplicación cliente):

```
┌─────────────────────────────────────────────────────────┐
│                    CLIENTE FLUTTER                      
│   [ Presentation Layer ] -> [ Domain ] -> [ Data ]      
└────────────────────────────┬────────────────────────────┘
                             │ REST / HTTP (JSON)
┌────────────────────────────▼────────────────────────────┐
│                    BACKEND NODE.JS                      
│   Routes  -->  Controllers  -->  Services  -->  Repos   
└────────────────────────────┬────────────────────────────┘
                             │ SQL / Transacciones
┌────────────────────────────▼────────────────────────────┐
│                BASE DE DATOS POSTGRESQL                 
│         Matches | Sectors | Buyers | Tickets            
└─────────────────────────────────────────────────────────┘

```

##  Guía de Instalación y Ejecución Reproducible

Sigue estos pasos para levantar el proyecto completo desde cero en un equipo limpio.

### 1. Requisitos Previos

* **Node.js:** v18.0.0 o superior

* **PostgreSQL:** v14.0 o superior

* **Flutter SDK:** v3.19.0 o superior (para ejecutar el cliente móvil/desktop)

* **Git**

### 2. Configurar la Base de Datos

1. Inicia sesión en PostgreSQL y crea la base de datos:

   ```
   CREATE DATABASE azulpass_db;
   
   ```

2. Ejecuta el script de creación inicial que genera tablas, relaciones y datos de prueba:

   ```
   psql -U postgres -d azulpass_db -f db/database.sql
   
   ```

### 3. Configurar y Levantamiento del Back-End

1. Entra a la carpeta del servidor:

   ```
   cd azulpass-backend
   
   ```

2. Instala las dependencias:

   ```
   npm install
   
   ```

3. Crea el archivo de variables de entorno a partir del archivo de ejemplo:

   ```
   cp .env.example .env
   
   ```

4. Revisa y ajusta `.env` con las credenciales de tu servidor PostgreSQL local:

   ```
   PORT=3000
   NODE_ENV=development
   DB_HOST=localhost
   DB_PORT=5432
   DB_NAME=azulpass_db
   DB_USER=postgres
   DB_PASSWORD=tu_contraseña_local
   JWT_SECRET=azulpass_secret_key_2026
   
   ```

5. Inicia el servidor en modo desarrollo:

   ```
   npm run dev
   
   ```

   El servidor quedará escuchando en `http://localhost:3000/api`.

### 4. Levantamiento del Cliente Flutter

1. En una nueva terminal, entra a la carpeta de la app:

   ```
   cd azul_pass
   
   ```

2. Obtén las dependencias de Flutter:

   ```
   flutter pub get
   
   ```

3. Ejecuta la aplicación (en navegador web, emulador Android o ejecutable Linux/macOS/Windows):

   ```
   flutter run -d chrome
   
   ```

##  Datos de Prueba para Evaluación

**Comprador de Prueba (Validación RUT):**

* * **RUT Válido:** `11.111.111-1`

  **Partidos y Sectores de Ejemplo:**

  * Partido ID `1`: Universidad de Chile vs. Colo-Colo (Estadio Nacional)

  * Sector ID `1`: Galería Sur (\$10.000 CLP)

  * Sector ID `2`: Andes (\$25.000 CLP)

##  Resumen de la API REST

| Verbo | Ruta | Descripción | 
| ----- | ----- | ----- | 
| `POST` | `/api/auth/login` | Autenticación y generación de token JWT | 
| `GET` | `/api/matches` | Lista de partidos programados y disponibilidad | 
| `GET` | `/api/matches/:id` | Detalle del partido y sus sectores | 
| `POST` | `/api/tickets` | Proceso transaccional de compra e emisión de entradas | 
| `GET` | `/api/tickets/:id` | Consulta de ticket por código único | 
| `GET` | `/api/buyers/:rut` | Consulta de datos e historial de comprador | 

## 📁 Estructura del Repositorio

```
azulpass/
├── README.md                          # Instrucciones principales de instalación y evaluador
├── .gitignore                         # Exclusión de credenciales y artefactos generados
├── db/
│   └── database.sql                   # Script SQL de creación e inserción de datos iniciales
├── docs/
│   ├── hito2_documento_tecnico_azulpass.pdf # Documento técnico de Back-End (Hito 2)
│   ├── manual_uso_e_instalacion.md    # Manual paso a paso y resolución de fallas
│   ├── hito3_documentacion_final_y_anexos.md # Bitácora, Ley 21.719 y Anexo IA (Hito 3)
│   └── guion_video_promocional.md     # Estructura del video de 2 minutos
├── azulpass-backend/                  # Código fuente del servicio Node.js / Express
│   ├── .env.example                   # Variables de entorno sin datos reales
│   └── src/                           # Capas: routes, controllers, services, repositories
└── azul_pass/                         # Código fuente del cliente Flutter

```

## 📑 Enlaces a Documentación Completa

* [Manual de Uso e Instalación Detallado](docs/manual_uso_e_instalacion.md)

* [Documentación Final Hito 3, Ley 21.719 y Anexo de IA](docs/hito3_documentacion_final_y_anexos.md)

* [Guion del Video Promocional](docs/guion_video_promocional.md)