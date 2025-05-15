# meat_project 🥩🥩🥩🥩🥩

# Prerrequisitos:
- MySQL workbench
- Jupyter Notebook con Python


# Introduccion: Análisis de Consumo de Carne y Sostenibilidad

En este proyecto vamos a ver la relación entre el desarrollo económico y el de consumo de carne a nivel mundial. Con datos de PIB per cápita y consumo de distintos tipos de carne, estudiamos la sostenibilidad alimentaria y hábitos por zonas influenciados por cultura y religión a lo largo de los ultimos 30 años.

En este proyecto usaremos conjuntos de datos relacionados y consultados en **MySQL Workbench** y un análisis posterior con graficas en **Python (Jupyter Notebook)**.

---

## Archivos necesarios

- `gdp_cleaned.csv`: PIB per cápita por país y año. (kaggle - https://www.kaggle.com/datasets/scibearia/meat-consumption-per-capita)
- `meat_consumption_cleaned.csv`: Consumo per cápita (kg/año) de varios tipos de carne por país y año. (kaggle - https://www.kaggle.com/datasets/scibearia/meat-consumption-per-capita)
- `countries.csv`: Lista de países.

---

## Objetivos del proyecto

- Explorar cómo el *PIB per cápita* se relaciona con el *consumo total de carne*.
- Comparar el consumo de *carne roja* vs. *opciones sostenibles* (pollo, pescado).
- Observar *diferencias regionales* influenciadas por religión y cultura.
- Estudiar la *evolución temporal* de hábitos alimentarios en España.

## Fase 1: Modelado y consultas SQL en MySQL Workbench
### Base de datos
- Esquema creado: `meat_project`
- Tablas importadas:
  - `countries.csv` a `countries`
  - `gdp_cleaned.csv` a `gdp_cleaned`
  - `meat_consumption_cleaned.csv` a `meat_consumption_cleaned`

### Primary keys y Foreign keys
- Se creó una columna `country_id` como primary key en `countries` que sera la foreign key en las otras dos.
- Creamos primary keys auto-incrementales (`gdp_id`, `consumption_id`) en las tablas de datos.
- Las relacionamos entre si:
  - `gdp_cleaned.country_id` a `countries.country_id`
  - `meat_consumption_cleaned.country_id` a `countries.country_id`

### Consultas realizadas
- Cálculo de consumo total de carne por país.
- Análisis por tipo de carne: carne roja vs opciones sostenibles.
- Medias por continente.
- Evolución temporal por país.
- Resultados ordenados por PIB per cápita y consumo total.

---

## Fase 2: Análisis en Jupyter Notebook

### Archivos usados
- `gdp_cleaned.csv`
- `meat_consumption_cleaned.csv`
- `countries.csv`

---

## Gráficas generadas (Python)

1. **PIB vs Consumo total de carne (2019)**  - Relación económica y alimentaria.
2. **Top 15 países por consumo total de carne**  - Ranking global de consumidores.
3. **Comparativa carne roja vs sostenible**  - ¿Qué tipo de carne predomina por país?
4. **Consumo medio por tipo y continente**  - Análisis regional influenciado por religión/cultura.
5. **Evolución en España (1990–2019)**  - Cambios en hábitos alimentarios en el tiempo.

---

## Conclusiones
- Existe relación positiva entre PIB per cápita y consumo total de carne.
- Europa y América lideran el consumo de carne roja, mientras que Asia y África tienen un perfil más sostenible, influenciado por religión y poder adquisitivo.
- En países como España, se observa una disminución del consumo de vacuno y un aumento progresivo del pollo, lo que puede interpretarse como un giro hacia patrones alimentarios más sostenibles.
- Las regiones con bajo consumo de cerdo (posiblemente por razones religiosas) compensan con otras fuentes de proteína como pescado o pollo.

## Mejoras y análisis futuros

- Añadir impacto ambiental: si se dispone de factores de emisiones por tipo de carne, calcular la huella de carbono asociada.
- Análisis por religión predominante: combinar con bases de datos demográficas para confirmar hipótesis culturales.