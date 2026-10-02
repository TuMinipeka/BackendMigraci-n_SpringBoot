# Backend de atención clínica con Spring Boot y Flyway

Backend modular basado en principios de Domain-Driven Design (DDD), preparado
para gestionar información clínica, pacientes, profesionales, encuentros,
tratamientos y conversaciones asistidas por inteligencia artificial.

El objetivo implementado actualmente es construir y versionar la estructura de
PostgreSQL mediante **Flyway y scripts SQL**, sin utilizar JPA para crear tablas
ni persistir información. El proyecto contiene 52 migraciones que materializan
el modelo relacional completo.

## Estado actual

| Componente | Estado |
| --- | --- |
| Esquema PostgreSQL | Implementado con 52 tablas |
| Migraciones Flyway | Implementadas desde `V1` hasta `V52` |
| Restricciones, relaciones e índices | Implementados mediante SQL |
| Entidades JPA | Aún no implementadas |
| Repositorios Spring Data JPA | Aún no implementados |
| Persistencia CRUD con Hibernate | Aún no implementada |
| Datos iniciales o de prueba | No incluidos actualmente |

Por tanto, el resultado actual es una base de datos estructuralmente completa,
pero sus tablas permanecen vacías hasta que se implemente la persistencia o se
agreguen migraciones de datos.

## Tecnologías

| Tecnología | Versión |
| --- | --- |
| Java | 21 |
| Spring Boot | 3.2.2 |
| Maven | 3.9+ |
| PostgreSQL JDBC | 42.7.13 |
| Flyway | 10.10.0 |
| PostgreSQL | Probado con PostgreSQL 18 |

Spring Data JPA está declarado como dependencia para una etapa posterior. En el
estado actual, Flyway accede a PostgreSQL mediante JDBC y obtiene conexiones del
pool HikariCP para ejecutar las migraciones.

## Arquitectura del proyecto

El repositorio es un proyecto Maven multimódulo:

```text
back-intro/
├── domain/          # Entidades, value objects, eventos y excepciones de dominio
├── application/     # Casos de uso, comandos, DTO y excepciones de aplicación
├── infrastructure/  # Spring Boot, persistencia, configuración y migraciones
├── pom.xml          # Agregador y administración central de dependencias
└── README.md
```

La clase de arranque se encuentra en:

```text
infrastructure/src/main/java/com/backintro/infrastructure/MiappApplication.java
```

## Flyway como objetivo principal

Flyway es el componente responsable de crear, versionar y validar la estructura
de la base de datos. Al iniciar Spring Boot realiza el siguiente proceso:

```text
Spring Boot inicia
    ↓
Flyway se conecta a PostgreSQL mediante JDBC/HikariCP
    ↓
Consulta flyway_schema_history_librarydb
    ↓
Detecta las versiones pendientes
    ↓
Ejecuta los archivos SQL en orden
    ↓
Registra cada resultado en el historial
```

Flyway creó directamente mediante SQL:

- el esquema `librarydb_schema`;
- las 52 tablas del modelo;
- claves primarias y foráneas;
- restricciones de unicidad y validación;
- índices para las relaciones y consultas principales;
- la tabla de control `flyway_schema_history_librarydb`.

Flyway no inserta información clínica ni ejecuta operaciones CRUD durante el
uso normal de la aplicación. Su responsabilidad es aplicar cambios controlados
y reproducibles sobre la base de datos.

## Modelo de base de datos

Las migraciones están en:

```text
infrastructure/src/main/resources/db/migration
```

Se ejecutan en orden desde `V1__create_Country_table.sql` hasta
`V52__create_Patient_Allergy_table.sql`.

Las 52 tablas se agrupan en las siguientes áreas:

- ubicación y catálogos: países, regiones, municipios, géneros y documentos;
- pacientes y profesionales: contactos, estudios, alergias y datos personales;
- historia clínica: registros clínicos, encuentros, notas y examen mental;
- evaluación y tratamiento: riesgos, planes, objetivos y estados;
- conversaciones: participantes, mensajes, prioridades y estados;
- inteligencia artificial: proveedores, modelos, ejecuciones, métricas y errores;
- escalaciones: asignaciones e historial de estados.

Flyway utiliza:

```text
Base de datos: librarydb
Esquema: librarydb_schema
Historial: librarydb_schema.flyway_schema_history_librarydb
```

### Cómo evoluciona la base de datos

Flyway no vuelve a ejecutar las migraciones que ya fueron aplicadas. Por
ejemplo, un cambio futuro debe añadirse como una nueva versión:

```sql
-- V53__add_status_to_patients.sql
ALTER TABLE ${db_schema}.patients
ADD COLUMN status VARCHAR(20);
```

En el siguiente arranque, Flyway conservará `V1`–`V52` y ejecutará únicamente
`V53`.

## Estado de JPA e Hibernate

Aunque `spring-boot-starter-data-jpa` está incluido en el módulo
`infrastructure`, **JPA todavía no se utiliza para persistir datos**.

Actualmente:

- `EmpresaJpaEntity` no está anotada con `@Entity`;
- `SpringDataEmpresaJpaRepository` no extiende `JpaRepository`;
- `EmpresaRepositoryAdapter` no implementa operaciones de persistencia;
- no existen consultas CRUD funcionales sobre las 52 tablas;
- Hibernate no participó en la creación de la estructura.

La propiedad configurada es:

```yaml
spring:
  jpa:
    hibernate:
      ddl-auto: validate
```

Esto impide que Hibernate cree o modifique tablas. Cuando se implementen las
entidades JPA, Hibernate solo validará que sus mapeos coincidan con la estructura
administrada por Flyway.

La separación de responsabilidades prevista es:

| Herramienta | Responsabilidad |
| --- | --- |
| Flyway | Crear y evolucionar el esquema con SQL versionado |
| JPA | Definir el estándar de mapeo entre objetos y tablas |
| Hibernate | Implementar JPA y ejecutar operaciones de persistencia |
| Spring Data JPA | Proporcionar repositorios para los Aggregates |
| HikariCP | Administrar y reutilizar conexiones JDBC |
| PostgreSQL | Almacenar finalmente la estructura y los datos |

## Requisitos previos

- JDK 21 disponible en `JAVA_HOME`.
- Maven 3.9 o superior.
- PostgreSQL en ejecución en el puerto 5432.
- Un usuario PostgreSQL con acceso a `librarydb` y permiso para crear el
  esquema administrado por Flyway.
- DBeaver es opcional, pero recomendado para inspeccionar tablas y relaciones.

Comprueba el entorno:

```powershell
java -version
javac -version
mvn -version
```

Los tres comandos deben utilizar Java 21.

## Preparación de PostgreSQL

Desde una sesión administrativa, por ejemplo con el usuario `postgres`, crea o
configura el usuario y la base de datos:

```sql
ALTER ROLE daniel WITH LOGIN CONNECTION LIMIT 20;
ALTER DATABASE librarydb OWNER TO daniel;
```

Si la base todavía no existe, créala en lugar de ejecutar el segundo comando:

```sql
CREATE DATABASE librarydb OWNER daniel;
```

Flyway creará automáticamente `librarydb_schema` durante el primer arranque.

## Configuración

El perfil predeterminado es `dev`. La configuración se encuentra en
`infrastructure/src/main/resources/application-dev.yml` y puede sobrescribirse
con variables de entorno:

| Variable | Valor local esperado |
| --- | --- |
| `DB_URL` | `jdbc:postgresql://localhost:5432/librarydb` |
| `DB_USERNAME` | `daniel` |
| `DB_PASSWORD` | Contraseña del usuario PostgreSQL |
| `DB_SCHEMA` | `librarydb_schema` |
| `SERVER_PORT` | `8081` |
| `SPRING_PROFILES_ACTIVE` | `dev` |

Ejemplo en PowerShell:

```powershell
$env:DB_URL = 'jdbc:postgresql://localhost:5432/librarydb'
$env:DB_USERNAME = 'daniel'
$env:DB_PASSWORD = 'su-clave-local'
$env:DB_SCHEMA = 'librarydb_schema'
```

No almacenes contraseñas reales de otros ambientes en el repositorio.

## Compilar y ejecutar

Desde la raíz del proyecto:

```powershell
mvn clean test
mvn -pl infrastructure spring-boot:run
```

Durante el arranque, Flyway valida el historial y aplica las migraciones
pendientes. Una instalación completa debe terminar en la versión `52`. Este
arranque comprueba la infraestructura de migraciones; todavía no ejecuta casos
de uso de persistencia mediante JPA.

La aplicación inicia de forma predeterminada en:

```text
http://localhost:8081
```

## Verificación en DBeaver

Configura una conexión PostgreSQL con los mismos valores utilizados por la
aplicación y navega hasta:

```text
librarydb
└── Schemas
    └── librarydb_schema
        └── Tables
```

Presiona `F5` para actualizar. Deben aparecer 52 tablas del modelo y la tabla
de historial de Flyway, para un total de 53 tablas.

Verifica el resultado con SQL:

```sql
SELECT COUNT(*) AS tablas_modelo
FROM information_schema.tables
WHERE table_schema = 'librarydb_schema'
  AND table_type = 'BASE TABLE'
  AND table_name <> 'flyway_schema_history_librarydb';

SELECT installed_rank, version, description, installed_on, success
FROM librarydb_schema.flyway_schema_history_librarydb
ORDER BY installed_rank;

SELECT COUNT(*) AS migraciones_fallidas
FROM librarydb_schema.flyway_schema_history_librarydb
WHERE NOT success;
```

Los resultados esperados son 52 tablas, versión final `52` y cero migraciones
fallidas. DBeaver también permite seleccionar las tablas y abrir **ER Diagram**
para visualizar las relaciones.

## Solución de problemas

### La aplicación se ejecuta con Java 17

El error `class file version 65.0 ... only recognizes up to 61.0` significa que
el código fue compilado con Java 21, pero se está ejecutando con Java 17.
Configura `JAVA_HOME` con el JDK 21, abre una terminal nueva y vuelve a ejecutar
una compilación limpia.

### Demasiadas conexiones para el rol

Comprueba el límite y las sesiones desde una cuenta administrativa:

```sql
SELECT rolname, rolconnlimit
FROM pg_roles
WHERE rolname = 'daniel';

SELECT pid, datname, application_name, state
FROM pg_stat_activity
WHERE usename = 'daniel';
```

Para el entorno local se configuró un límite de 20 conexiones.

### No existe la base de datos

La URL debe terminar en `/librarydb`, no en `/librarysdb`. Si `librarydb` no
existe, créala con un usuario administrador.

### Permiso denegado al crear el esquema

El usuario de la aplicación debe ser propietario de la base o disponer del
permiso `CREATE`:

```sql
ALTER DATABASE librarydb OWNER TO daniel;
```

## Convenciones de migración

- Cada cambio estructural nuevo debe añadirse en una migración posterior.
- No se deben modificar migraciones que ya hayan sido ejecutadas en ambientes
  compartidos.
- El nombre debe seguir el patrón `V<numero>__<descripcion>.sql`.
- Hibernate tiene `ddl-auto: validate`; Flyway es el responsable exclusivo de
  crear y evolucionar el esquema.

Para detalles adicionales de conexión y consultas de diagnóstico consulta
[`infrastructure/DATABASE.md`](infrastructure/DATABASE.md).
