# Описание запросов
Этот файл содержит описание SQL запросов для КДЗ по базам данных. 
# aggregate zap

## Запрос 1

```sql
SELECT
    p.project_name,
    COUNT(v.id) AS vacancy_count,
    AVG(v.salary) AS avg_salary
FROM
    project p
        JOIN vacancy v ON p.id = v.project_id
        JOIN customer c ON v.customer_id = c.id
GROUP BY
    p.project_name;
```

### Описание:
Этот запрос выполняет следующее:
1. Он выбирает данные из таблиц `project`, `vacancy` и `customer`.
2. Используется `JOIN` для объединения таблиц `project` и `vacancy` по полю `project_id`, а также таблиц `vacancy` и `customer` по полю `customer_id`.
3. Запрос группирует результаты по полю `project_name` из таблицы `project`.
4. Для каждого проекта (`project_name`) запрос подсчитывает количество вакансий (`COUNT(v.id)`) и вычисляет среднюю зарплату (`AVG(v.salary)`).
5. Результатом запроса будет список проектов с количеством вакансий и средней зарплатой для каждого проекта.

## Запрос 2

```sql
SELECT
    l.location,
    COUNT(v.id) AS vacancy_count,
    AVG(v.salary) AS avg_salary
FROM
    location l
        JOIN vacancy v ON l.id = v.location_id
        JOIN customer c ON v.customer_id = c.id
GROUP BY
    l.location;
```

### Описание:
Этот запрос выполняет следующее:
1. Он выбирает данные из таблиц `location`, `vacancy` и `customer`.
2. Используется `JOIN` для объединения таблиц `location` и `vacancy` по полю `location_id`, а также таблиц `vacancy` и `customer` по полю `customer_id`.
3. Запрос группирует результаты по полю `location` из таблицы `location`.
4. Для каждой локации (`location`) запрос подсчитывает количество вакансий (`COUNT(v.id)`) и вычисляет среднюю зарплату (`AVG(v.salary)`).
5. Результатом запроса будет список локаций с количеством вакансий и средней зарплатой для каждой локации.

## Запрос 3

```sql
SELECT
    r.role_name,
    COUNT(v.id) AS vacancy_count,
    AVG(v.salary) AS avg_salary
FROM
    role r
        JOIN vacancy v ON r.id = v.role_id
        JOIN project p ON v.project_id = p.id
GROUP BY
    r.role_name;
```

### Описание:
Этот запрос выполняет следующее:
1. Он выбирает данные из таблиц `role`, `vacancy` и `project`.
2. Используется `JOIN` для объединения таблиц `role` и `vacancy` по полю `role_id`, а также таблиц `vacancy` и `project` по полю `project_id`.
3. Запрос группирует результаты по полю `role_name` из таблицы `role`.
4. Для каждой роли (`role_name`) запрос подсчитывает количество вакансий (`COUNT(v.id)`) и вычисляет среднюю зарплату (`AVG(v.salary)`).
5. Результатом запроса будет список ролей с количеством вакансий и средней зарплатой для каждой роли.

Все три запроса используют агрегатные функции `COUNT` и `AVG` для подсчета количества вакансий и вычисления средней зарплаты соответственно, группируя результаты по определенному полю (project_name, location или role_name).

Эти запросы позволяют получить статистическую информацию о количестве вакансий и средней зарплате в разрезе проектов, локаций и ролей. Такая информация может быть полезна для анализа распределения вакансий и зарплат в компании, а также для принятия решений о планировании и бюджетировании.

Использование JOIN позволяет связать данные из разных таблиц и получить более полную картину, учитывая связи между проектами, вакансиями, локациями, ролями и заказчиками.

# ags zap
## Запрос 1

```sql
SELECT
    p.project_name,
    COUNT(v.id) AS vacancy_count,
    AVG(v.salary) AS avg_salary
FROM
    project p
        LEFT JOIN (
        SELECT *
        FROM vacancy
        WHERE status = 'Open'
    ) v ON p.id = v.project_id
GROUP BY
    p.project_name
ORDER BY
    vacancy_count DESC;
```

### Описание:
Этот запрос выполняет следующее:
1. Он выбирает данные из таблиц `project` и `vacancy`.
2. Используется `LEFT JOIN` для объединения таблицы `project` с подзапросом, который выбирает только открытые вакансии (`status = 'Open'`) из таблицы `vacancy`. Это гарантирует, что все проекты будут включены в результат, даже если у них нет открытых вакансий.
3. Запрос группирует результаты по полю `project_name` из таблицы `project`.
4. Для каждого проекта (`project_name`) запрос подсчитывает количество открытых вакансий (`COUNT(v.id)`) и вычисляет среднюю зарплату (`AVG(v.salary)`).
5. Результаты сортируются по количеству открытых вакансий в порядке убывания (`ORDER BY vacancy_count DESC`).
6. Результатом запроса будет список проектов с количеством открытых вакансий и средней зарплатой для каждого проекта, отсортированный по количеству открытых вакансий в порядке убывания.

## Запрос 2

```sql
SELECT
    c.customer_name,
    v.position,
    AVG(v.salary) AS avg_salary
FROM
    customer c
        LEFT JOIN (
        SELECT *
        FROM vacancy
        WHERE status = 'Open'
    ) v ON c.id = v.customer_id
GROUP BY
    c.customer_name, v.position
ORDER BY
    avg_salary DESC;
```

### Описание:
Этот запрос выполняет следующее:
1. Он выбирает данные из таблиц `customer` и `vacancy`.
2. Используется `LEFT JOIN` для объединения таблицы `customer` с подзапросом, который выбирает только открытые вакансии (`status = 'Open'`) из таблицы `vacancy`. Это гарантирует, что все заказчики будут включены в результат, даже если у них нет открытых вакансий.
3. Запрос группирует результаты по полям `customer_name` из таблицы `customer` и `position` из таблицы `vacancy`.
4. Для каждой комбинации заказчика (`customer_name`) и должности (`position`) запрос вычисляет среднюю зарплату (`AVG(v.salary)`).
5. Результаты сортируются по средней зарплате в порядке убывания (`ORDER BY avg_salary DESC`).
6. Результатом запроса будет список заказчиков и должностей с соответствующей средней зарплатой, отсортированный по средней зарплате в порядке убывания.

Оба запроса используют `LEFT JOIN` для объединения таблиц `project` и `customer` с подзапросом, который выбирает только открытые вакансии. Это позволяет получить полную информацию о проектах и заказчиках, даже если у них нет открытых вакансий.

# case+agr zap
## Запрос

```sql
SELECT
    p.project_name,
    COUNT(CASE WHEN v.status = 'Open' THEN 1 END) AS open_vacancies,
    COUNT(CASE WHEN v.status = 'Closed' THEN 1 END) AS closed_vacancies
FROM
    project p
        LEFT JOIN vacancy v ON p.id = v.project_id
GROUP BY
    p.project_name;
```

### Описание:
Этот запрос выполняет следующее:
1. Он выбирает данные из таблиц `project` и `vacancy`.
2. Используется `LEFT JOIN` для объединения таблицы `project` с таблицей `vacancy` по полю `project_id`. Это гарантирует, что все проекты будут включены в результат, даже если у них нет связанных вакансий.
3. Запрос группирует результаты по полю `project_name` из таблицы `project`.
4. Для каждого проекта (`project_name`) запрос подсчитывает количество открытых вакансий (`COUNT(CASE WHEN v.status = 'Open' THEN 1 END)`) и количество закрытых вакансий (`COUNT(CASE WHEN v.status = 'Closed' THEN 1 END)`).
    - Условный оператор `CASE` проверяет значение поля `status` для каждой вакансии. Если `status = 'Open'`, то для этой вакансии будет посчитано значение 1 в столбце `open_vacancies`. Если `status = 'Closed'`, то для этой вакансии будет посчитано значение 1 в столбце `closed_vacancies`.
5. Результатом запроса будет список проектов с количеством открытых и закрытых вакансий для каждого проекта.

Этот запрос использует условный оператор `CASE` внутри агрегатной функции `COUNT`, чтобы подсчитать количество открытых и закрытых вакансий отдельно для каждого проекта. Это позволяет получить более детальную информацию о статусе вакансий для каждого проекта.

# exists zap
## Запрос

```sql
SELECT
    c.id,
    c.name
FROM
    candidate c
WHERE
    EXISTS (
        SELECT 1
        FROM offer o
        WHERE o.candidate_id = c.id
    );
```

### Описание:
Этот запрос выполняет следующее:
1. Он выбирает поля `id` и `name` из таблицы `candidate`.
2. Используется условие `WHERE EXISTS` для фильтрации результатов.
    - Подзапрос внутри `EXISTS` проверяет наличие записей в таблице `offer`, где `candidate_id` из таблицы `offer` совпадает с `id` текущего кандидата из таблицы `candidate`.
    - Если для кандидата существует хотя бы одна запись в таблице `offer`, то подзапрос вернет значение `1`, и условие `EXISTS` будет истинным.
3. Запрос вернет только тех кандидатов, для которых есть связанные записи в таблице `offer`.

Этот запрос использует условие `EXISTS` для проверки наличия связанных записей в другой таблице. Он позволяет выбрать только тех кандидатов, которым было сделано предложение (записи в таблице `offer`).

Подзапрос внутри `EXISTS` не возвращает фактические данные, а только проверяет наличие записей. Если запись существует, то подзапрос вернет значение `1`, и условие `EXISTS` будет истинным для текущего кандидата.
# functions
## Функция 1: `get_candidates_with_test_results`

```sql
CREATE OR REPLACE FUNCTION get_candidates_with_test_results()
    RETURNS TABLE (
                      candidate_id INTEGER,
                      name VARCHAR(45),
                      verbal_test INTEGER,
                      numeric_test INTEGER,
                      prof_test INTEGER
                  )
    LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
        SELECT c.id, c.name, t.verbal_test, t.numeric_test, t.prof_test
        FROM candidate c
                 LEFT JOIN talentq_check t ON c.id = t.candidate_id;
END;
$$;
```

### Описание:
Эта функция выполняет следующее:
1. Она создает или заменяет функцию `get_candidates_with_test_results()`.
2. Функция возвращает таблицу с полями `candidate_id`, `name`, `verbal_test`, `numeric_test` и `prof_test`.
3. Внутри функции используется оператор `RETURN QUERY`, который возвращает результаты запроса.
4. Запрос выбирает поля `id` и `name` из таблицы `candidate`, а также поля `verbal_test`, `numeric_test` и `prof_test` из таблицы `talentq_check`.
5. Используется `LEFT JOIN` для объединения таблиц `candidate` и `talentq_check` по полю `candidate_id`. Это гарантирует, что все кандидаты будут включены в результат, даже если у них нет связанных результатов тестов.

Эта функция возвращает таблицу, содержащую информацию о кандидатах и их результатах тестов. Она объединяет данные из таблиц `candidate` и `talentq_check`, чтобы получить полную информацию о каждом кандидате, включая их результаты вербального, числового и профессионального тестов.

## Функция 2: `get_vacancy_count_by_project`

```sql
CREATE OR REPLACE FUNCTION get_vacancy_count_by_project(p_project_id INTEGER)
    RETURNS INTEGER
    LANGUAGE plpgsql
AS $$
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM vacancy
    WHERE project_id = p_project_id;

    RETURN v_count;
END;
$$;
```

### Описание:
Эта функция выполняет следующее:
1. Она создает или заменяет функцию `get_vacancy_count_by_project`, которая принимает параметр `p_project_id` типа `INTEGER`.
2. Функция возвращает значение типа `INTEGER`.
3. Внутри функции объявляется переменная `v_count` типа `INTEGER` для хранения результата.
4. Выполняется запрос `SELECT COUNT(*) INTO v_count` для подсчета количества записей в таблице `vacancy`, где `project_id` совпадает с переданным параметром `p_project_id`.
5. Результат запроса сохраняется в переменной `v_count`.
6. Функция возвращает значение переменной `v_count`.

Эта функция принимает идентификатор проекта (`p_project_id`) в качестве параметра и возвращает количество вакансий, связанных с этим проектом. Она выполняет запрос `COUNT(*)` для подсчета количества записей в таблице `vacancy`, где `project_id` совпадает с переданным значением параметра.
# having zap
## Запрос

```sql
SELECT
    p.project_name,
    COUNT(v.id) AS vacancy_count
FROM
    project p
        JOIN vacancy v ON p.id = v.project_id
GROUP BY
    p.project_name
HAVING
    COUNT(v.id) > 5;
```

### Описание:
Этот запрос выполняет следующее:
1. Он выбирает поля `project_name` из таблицы `project` и подсчитывает количество вакансий для каждого проекта с помощью `COUNT(v.id)`, присваивая результату псевдоним `vacancy_count`.
2. Используется `JOIN` для объединения таблиц `project` и `vacancy` по полю `project_id`, чтобы связать каждую вакансию с соответствующим проектом.
3. Запрос группирует результаты по полю `project_name` из таблицы `project` с помощью `GROUP BY`. Это означает, что результаты будут сгруппированы по уникальным значениям `project_name`.
4. После группировки применяется условие `HAVING COUNT(v.id) > 5`, которое фильтрует результаты и оставляет только те группы (проекты), где количество вакансий больше 5.

Этот запрос позволяет получить список проектов и количество связанных с ними вакансий, но только для тех проектов, где количество вакансий превышает 5.

Ключевые моменты:
- `JOIN` используется для объединения таблиц `project` и `vacancy` на основе связи между `project_id`.
- `GROUP BY` группирует результаты по полю `project_name`, чтобы получить уникальные значения проектов.
- `COUNT(v.id)` подсчитывает количество вакансий для каждого проекта.
- `HAVING` фильтрует сгруппированные результаты и оставляет только те проекты, где количество вакансий больше 5.

Условие `HAVING` применяется после группировки и позволяет фильтровать результаты на основе агрегированных значений, таких как `COUNT(v.id)`. Оно отличается от условия `WHERE`, которое применяется до группировки и фильтрует отдельные строки.
# join zap
## Запрос

```sql
SELECT
    p.project_name,
    c.customer_name,
    COUNT(v.id) AS vacancy_count,
    AVG(v.salary) AS avg_salary
FROM
    project p
        JOIN vacancy v ON p.id = v.project_id
        JOIN customer c ON v.customer_id = c.id
        JOIN offer o ON v.id = o.vacancy_id
GROUP BY
    p.project_name,
    c.customer_name;
```

### Описание:
Этот запрос выполняет следующее:
1. Он выбирает поля `project_name` из таблицы `project`, `customer_name` из таблицы `customer`, подсчитывает количество вакансий для каждой комбинации проекта и заказчика с помощью `COUNT(v.id)` и вычисляет среднюю зарплату для этих вакансий с помощью `AVG(v.salary)`.
2. Используется серия `JOIN` для объединения таблиц:
    - `project` и `vacancy` объединяются по полю `project_id`, чтобы связать каждую вакансию с соответствующим проектом.
    - `vacancy` и `customer` объединяются по полю `customer_id`, чтобы связать каждую вакансию с соответствующим заказчиком.
    - `vacancy` и `offer` объединяются по полю `vacancy_id`, чтобы связать каждую вакансию с соответствующим предложением.
3. Запрос группирует результаты по полям `project_name` и `customer_name` с помощью `GROUP BY`. Это означает, что результаты будут сгруппированы по уникальным комбинациям значений `project_name` и `customer_name`.
4. Для каждой группы (комбинации проекта и заказчика) запрос подсчитывает количество вакансий с помощью `COUNT(v.id)` и вычисляет среднюю зарплату с помощью `AVG(v.salary)`.

Этот запрос позволяет получить информацию о количестве вакансий и средней зарплате для каждой комбинации проекта и заказчика, но только для тех вакансий, для которых есть связанные предложения (записи в таблице `offer`).

Ключевые моменты:
- Используется серия `JOIN` для объединения таблиц `project`, `vacancy`, `customer` и `offer` на основе связей между соответствующими полями.
- `GROUP BY` группирует результаты по полям `project_name` и `customer_name`, чтобы получить уникальные комбинации проектов и заказчиков.
- `COUNT(v.id)` подсчитывает количество вакансий для каждой комбинации проекта и заказчика.
- `AVG(v.salary)` вычисляет среднюю зарплату для вакансий в каждой комбинации проекта и заказчика.

Обратите внимание, что в результате будут только те комбинации проектов и заказчиков, для которых есть связанные вакансии и предложения. Комбинации без вакансий или предложений будут исключены из результата.
# korr zap
## Запрос 1

```sql
SELECT
    c.id,
    c.name,
    (SELECT COUNT(*) FROM offer o WHERE o.candidate_id = c.id) AS offer_count
FROM
    candidate c;
```

### Описание:
Этот запрос выполняет следующее:
1. Он выбирает поля `id` и `name` из таблицы `candidate`.
2. Для каждого кандидата выполняется подзапрос `(SELECT COUNT(*) FROM offer o WHERE o.candidate_id = c.id)`, который подсчитывает количество записей в таблице `offer`, где `candidate_id` совпадает с `id` текущего кандидата.
3. Результат подзапроса присваивается псевдониму `offer_count`, который представляет количество предложений для каждого кандидата.

Этот запрос использует коррелированный подзапрос для подсчета количества предложений, связанных с каждым кандидатом. Для каждой строки в таблице `candidate` выполняется подзапрос, который подсчитывает количество записей в таблице `offer`, где `candidate_id` совпадает с `id` текущего кандидата.

Ключевые моменты:
- Основной запрос выбирает поля `id` и `name` из таблицы `candidate`.
- Коррелированный подзапрос `(SELECT COUNT(*) FROM offer o WHERE o.candidate_id = c.id)` подсчитывает количество предложений для каждого кандидата.
- Псевдоним `offer_count` присваивается результату подзапроса, представляя количество предложений для каждого кандидата.

## Запрос 2

```sql
SELECT
    v.id,
    v.position,
    (SELECT COUNT(*) FROM offer o WHERE o.vacancy_id = v.id) AS offer_count
FROM
    vacancy v;
```

### Описание:
Этот запрос выполняет следующее:
1. Он выбирает поля `id` и `position` из таблицы `vacancy`.
2. Для каждой вакансии выполняется подзапрос `(SELECT COUNT(*) FROM offer o WHERE o.vacancy_id = v.id)`, который подсчитывает количество записей в таблице `offer`, где `vacancy_id` совпадает с `id` текущей вакансии.
3. Результат подзапроса присваивается псевдониму `offer_count`, который представляет количество предложений для каждой вакансии.

Этот запрос использует коррелированный подзапрос для подсчета количества предложений, связанных с каждой вакансией. Для каждой строки в таблице `vacancy` выполняется подзапрос, который подсчитывает количество записей в таблице `offer`, где `vacancy_id` совпадает с `id` текущей вакансии.

Ключевые моменты:
- Основной запрос выбирает поля `id` и `position` из таблицы `vacancy`.
- Коррелированный подзапрос `(SELECT COUNT(*) FROM offer o WHERE o.vacancy_id = v.id)` подсчитывает количество предложений для каждой вакансии.
- Псевдоним `offer_count` присваивается результату подзапроса, представляя количество предложений для каждой вакансии.

Оба запроса используют коррелированные подзапросы для подсчета количества связанных записей в таблице `offer` для каждого кандидата и вакансии соответственно. Это позволяет получить информацию о количестве предложений, связанных с каждым кандидатом и вакансией, без необходимости явного объединения таблиц.

Коррелированные подзапросы выполняются для каждой строки основного запроса и используют значения из текущей строки для фильтрации результатов подзапроса. Это позволяет получить связанные данные для каждой строки основного запроса.

В первом запросе коррелированный подзапрос подсчитывает количество предложений для каждого кандидата, сопоставляя `candidate_id` из таблицы `offer` с `id` текущего кандидата.

Во втором запросе коррелированный подзапрос подсчитывает количество предложений для каждой вакансии, сопоставляя `vacancy_id` из таблицы `offer` с `id` текущей вакансии.

Результаты запросов будут содержать информацию о каждом кандидате (или вакансии) вместе с количеством связанных с ним предложений. Это может быть полезно для анализа популярности кандидатов или вакансий, а также для определения наиболее активных кандидатов или вакансий с наибольшим количеством предложений.

Коррелированные подзапросы могут быть менее эффективными по сравнению с явным объединением таблиц, особенно при большом объеме данных, но они предоставляют более гибкий и интуитивно понятный способ получения связанных данных для каждой строки основного запроса.
# korr zap 2
# Запрос 1

```sql
SELECT
    c.id,
    c.name
FROM
    candidate c
WHERE
    EXISTS (
        SELECT 1
        FROM offer o
        WHERE o.candidate_id = c.id AND o.accept = true
    );
```

Этот запрос выбирает `id` и `name` из таблицы `candidate` для тех кандидатов, у которых существует принятое предложение о работе (`offer`) с `accept = true`.

Внутренний подзапрос `EXISTS` проверяет наличие строк в таблице `offer`, где `candidate_id` совпадает с `id` кандидата из внешнего запроса, и `accept` имеет значение `true`.

# Запрос 2

```sql
SELECT
    c.id,
    c.name
FROM
    candidate c
WHERE
    NOT EXISTS (
        SELECT 1
        FROM offer o
        WHERE o.candidate_id = c.id AND o.accept = false
    );
```

Этот запрос выбирает `id` и `name` из таблицы `candidate` для тех кандидатов, у которых не существует отклоненного предложения о работе (`offer`) с `accept = false`.

Внутренний подзапрос `NOT EXISTS` проверяет отсутствие строк в таблице `offer`, где `candidate_id` совпадает с `id` кандидата из внешнего запроса, и `accept` имеет значение `false`.

Таким образом, этот запрос возвращает кандидатов, которые либо не получали предложений о работе, либо все их предложения были приняты.
# lag zap
```sql
SELECT
    v.id,
    v.position,
    v.salary,
    LAG(v.salary) OVER (ORDER BY v.start_date) AS prev_salary
FROM
    vacancy v;
```

Этот SQL-запрос выбирает несколько столбцов из таблицы `vacancy`, включая `id`, `position` и `salary`. Кроме того, он добавляет вычисляемый столбец `prev_salary`, который содержит значение `salary` для предыдущей строки в наборе результатов.

Вычисление `prev_salary` выполняется с помощью оконной функции `LAG`. Оконные функции работают с наборами строк, называемыми окнами, а не с отдельными строками. В данном случае окно определяется с помощью предложения `OVER (ORDER BY v.start_date)`, что означает, что строки будут упорядочены по значению столбца `start_date` перед применением функции `LAG`.

Функция `LAG` принимает один аргумент - значение, для которого нужно найти предыдущее значение в окне. В данном случае это `v.salary`. Таким образом, `LAG(v.salary)` возвращает значение `salary` для предыдущей строки в упорядоченном по `start_date` наборе строк.

Результирующий набор данных будет содержать четыре столбца:

1. `id` - идентификатор вакансии.
2. `position` - название позиции вакансии.
3. `salary` - зарплата для данной вакансии.
4. `prev_salary` - зарплата для предыдущей вакансии в порядке `start_date`.

Этот запрос может быть полезен для анализа изменений зарплат для вакансий во времени, а также для выявления аномалий или необычных скачков в зарплатах.
# lite zap
# Запрос 1

```sql
SELECT
    id,
    position,
    salary,
    salary * 1.1 AS increased_salary
FROM
    vacancy
WHERE
    status = 'Open';
```

Этот запрос выбирает `id`, `position`, `salary` из таблицы `vacancy`, а также добавляет вычисляемый столбец `increased_salary`, который содержит значение `salary`, увеличенное на 10%. Запрос применяется только к вакансиям со статусом `'Open'` (открытым).

Вычисление `increased_salary` выполняется путем умножения значения `salary` на 1.1 (что эквивалентно увеличению на 10%).

Результирующий набор данных будет содержать четыре столбца:

1. `id` - идентификатор вакансии.
2. `position` - название позиции вакансии.
3. `salary` - текущая зарплата для данной вакансии.
4. `increased_salary` - зарплата, увеличенная на 10% по сравнению с текущей.

Этот запрос может быть полезен для анализа потенциального увеличения зарплат для открытых вакансий.

# Запрос 2

```sql
SELECT
    id,
    position,
    salary * 0.87 AS salary_after_tax
FROM
    vacancy
WHERE
    status = 'Open' AND salary > 50000;
```

Этот запрос выбирает `id`, `position` из таблицы `vacancy`, а также добавляет вычисляемый столбец `salary_after_tax`, который содержит значение `salary`, уменьшенное на 13% (что соответствует налоговой ставке 13%). Запрос применяется только к вакансиям со статусом `'Open'` (открытым) и зарплатой выше 50000.

Вычисление `salary_after_tax` выполняется путем умножения значения `salary` на 0.87 (что эквивалентно уменьшению на 13%).

Результирующий набор данных будет содержать три столбца:

1. `id` - идентификатор вакансии.
2. `position` - название позиции вакансии.
3. `salary_after_tax` - зарплата после вычета налога в 13% для вакансий с зарплатой выше 50000.

Этот запрос может быть полезен для анализа зарплат после вычета налогов для высокооплачиваемых открытых вакансий.
# mn zap
```sql
SELECT name FROM candidate
UNION
SELECT name FROM hr_;
```

Запрос:
Этот запрос объединяет имена из таблиц `candidate` и `hr_` с помощью оператора `UNION`.

Ключевые моменты:
- Использование `UNION` для объединения результатов двух `SELECT` запросов.
- Удаление дубликатов в объединенном наборе данных.

Вывод:
Результирующий набор данных будет содержать один столбец `name` с уникальными значениями имен из таблиц `candidate` и `hr_`.
# null zap
```sql
SELECT
    c.name AS candidate_name,
    o.comment AS offer_comment
FROM
    candidate c
        LEFT JOIN offer o ON c.id = o.candidate_id
WHERE
    o.comment IS NULL;
```

Запрос:
Этот запрос выполняет левое внешнее соединение (`LEFT JOIN`) таблиц `candidate` и `offer` по условию `c.id = o.candidate_id`.

Ключевые моменты:
- Использование `LEFT JOIN` для включения всех записей из таблицы `candidate`, даже если для них нет соответствующих записей в таблице `offer`.
- Выбор столбцов `name` из таблицы `candidate` с псевдонимом `candidate_name` и `comment` из таблицы `offer` с псевдонимом `offer_comment`.
- Условие `WHERE o.comment IS NULL` отфильтровывает только те записи, где значение `comment` в таблице `offer` равно `NULL`.

Вывод:
Результирующий набор данных будет содержать два столбца:
1. `candidate_name` - имя кандидата из таблицы `candidate`.
2. `offer_comment` - значение столбца `comment` из таблицы `offer`. Если для кандидата нет записи в таблице `offer`, то значение будет `NULL`.

Этот запрос выводит имена кандидатов, для которых нет комментариев к предложению о работе в таблице `offer`.
# podzap zap
# Запрос 1

```sql
SELECT
    v.id,
    v.position,
    c.name AS candidate_name
FROM
    vacancy v
        JOIN (
        SELECT candidate_id, vacancy_id
        FROM offer
        WHERE accept = true
    ) o ON v.id = o.vacancy_id
        JOIN candidate c ON o.candidate_id = c.id;
```

Запрос:
Этот запрос выполняет соединение трех таблиц: `vacancy`, `offer` и `candidate`.

Ключевые моменты:
- Используется вложенный подзапрос для выборки `candidate_id` и `vacancy_id` из таблицы `offer`, где `accept` равно `true` (принятые предложения).
- Результат подзапроса соединяется с таблицей `vacancy` по условию `v.id = o.vacancy_id`.
- Затем к результату присоединяется таблица `candidate` по условию `o.candidate_id = c.id`.
- Выбираются столбцы `id` и `position` из таблицы `vacancy`, а также `name` из таблицы `candidate` с псевдонимом `candidate_name`.

Вывод:
Результирующий набор данных будет содержать три столбца:
1. `id` - идентификатор вакансии.
2. `position` - название позиции вакансии.
3. `candidate_name` - имя кандидата, принявшего предложение для данной вакансии.

# Запрос 2

```sql
SELECT
    c.name,
    o.comment
FROM
    candidate c
        JOIN (
        SELECT candidate_id, comment
        FROM offer
        WHERE accept = true
    ) o ON c.id = o.candidate_id;
```

Запрос:
Этот запрос выполняет соединение таблиц `candidate` и `offer`.

Ключевые моменты:
- Используется вложенный подзапрос для выборки `candidate_id` и `comment` из таблицы `offer`, где `accept` равно `true` (принятые предложения).
- Результат подзапроса соединяется с таблицей `candidate` по условию `c.id = o.candidate_id`.
- Выбираются столбцы `name` из таблицы `candidate` и `comment` из результата подзапроса.

Вывод:
Результирующий набор данных будет содержать два столбца:
1. `name` - имя кандидата из таблицы `candidate`.
2. `comment` - комментарий к принятому предложению для данного кандидата из таблицы `offer`.
# pred
# Создание представления `vacancy_info`

```sql
CREATE OR REPLACE VIEW vacancy_info AS
SELECT
    v.id,
    v.position,
    p.project_name,
    c.customer_name,
    v.start_date,
    v.finish_date,
    v.status
FROM
    vacancy v
        JOIN project p ON v.project_id = p.id
        JOIN customer c ON v.customer_id = c.id;
```

Этот запрос создает или заменяет представление `vacancy_info`, которое объединяет данные из таблиц `vacancy`, `project` и `customer`.

Ключевые моменты:
- Используется оператор `CREATE OR REPLACE VIEW` для создания или замены существующего представления.
- Выбираются столбцы `id`, `position`, `start_date`, `finish_date` и `status` из таблицы `vacancy`.
- Добавляется столбец `project_name` из таблицы `project` с помощью соединения `JOIN` по условию `v.project_id = p.id`.
- Добавляется столбец `customer_name` из таблицы `customer` с помощью соединения `JOIN` по условию `v.customer_id = c.id`.

Вывод:
Представление `vacancy_info` будет содержать следующие столбцы:
1. `id` - идентификатор вакансии.
2. `position` - название позиции вакансии.
3. `project_name` - название проекта, связанного с вакансией.
4. `customer_name` - название компании-заказчика, связанной с вакансией.
5. `start_date` - дата начала вакансии.
6. `finish_date` - дата окончания вакансии.
7. `status` - статус вакансии.

# Создание представления `candidate_check_status`

```sql
CREATE OR REPLACE VIEW candidate_check_status AS
SELECT
    c.id,
    c.name,
    t.status AS talentq_status,
    s.status AS security_status
FROM
    candidate c
        LEFT JOIN talentq_check t ON c.id = t.candidate_id
        LEFT JOIN security_check s ON c.id = s.candidate_id;
```

Этот запрос создает или заменяет представление `candidate_check_status`, которое объединяет данные из таблиц `candidate`, `talentq_check` и `security_check`.

Ключевые моменты:
- Используется оператор `CREATE OR REPLACE VIEW` для создания или замены существующего представления.
- Выбираются столбцы `id` и `name` из таблицы `candidate`.
- Добавляется столбец `talentq_status` из таблицы `talentq_check` с помощью левого внешнего соединения `LEFT JOIN` по условию `c.id = t.candidate_id`.
- Добавляется столбец `security_status` из таблицы `security_check` с помощью левого внешнего соединения `LEFT JOIN` по условию `c.id = s.candidate_id`.

Вывод:
Представление `candidate_check_status` будет содержать следующие столбцы:
1. `id` - идентификатор кандидата.
2. `name` - имя кандидата.
3. `talentq_status` - статус проверки TalentQ для кандидата.
4. `security_status` - статус проверки безопасности для кандидата.
# procedure
# Процедура `update_vacancy_status()`

```sql
CREATE OR REPLACE PROCEDURE update_vacancy_status()
    LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE vacancy
    SET status = 'Closed'
    WHERE id IN (
        SELECT vacancy_id
        FROM offer
        WHERE accept = true
    );
END;
$$;
```

Эта процедура обновляет статус вакансий на `'Closed'` (закрытая), если для них существует принятое предложение (`accept = true`) в таблице `offer`.

Ключевые моменты:
- Используется оператор `CREATE OR REPLACE PROCEDURE` для создания или замены существующей процедуры.
- Внутри процедуры выполняется оператор `UPDATE` для изменения статуса вакансий.
- Условие `WHERE id IN (...)` определяет идентификаторы вакансий, для которых существуют принятые предложения.
- Вложенный подзапрос `SELECT vacancy_id FROM offer WHERE accept = true` выбирает идентификаторы вакансий с принятыми предложениями.

# Процедура `process_candidate(p_candidate_id INTEGER)`

```sql
CREATE OR REPLACE PROCEDURE process_candidate(p_candidate_id INTEGER)
    LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM candidate WHERE id = p_candidate_id) THEN
        UPDATE candidate SET relocation_status = 'In Progress' WHERE id = p_candidate_id;
        INSERT INTO talentq_check (candidate_id, status) VALUES (p_candidate_id, 'Sent');
        INSERT INTO security_check (candidate_id, status) VALUES (p_candidate_id, 'Sent');
    ELSE
        RAISE EXCEPTION 'Candidate not found';
    END IF;
END;
$$;
```

Эта процедура выполняет следующие действия для указанного кандидата (`p_candidate_id`):

1. Проверяет, существует ли кандидат с указанным идентификатором в таблице `candidate`.
2. Если кандидат существует, то:
    - Обновляет статус `relocation_status` кандидата на `'In Progress'`.
    - Вставляет новую запись в таблицу `talentq_check` со статусом `'Sent'` для данного кандидата.
    - Вставляет новую запись в таблицу `security_check` со статусом `'Sent'` для данного кандидата.
3. Если кандидат не найден, выбрасывается исключение с сообщением `'Candidate not found'`.

# Процедура `add_candidate(p_name VARCHAR(45), p_birth_date DATE, p_phone VARCHAR(400), p_mail VARCHAR(400))`

```sql
CREATE OR REPLACE PROCEDURE add_candidate(
    p_name VARCHAR(45),
    p_birth_date DATE,
    p_phone VARCHAR(400),
    p_mail VARCHAR(400)
)
    LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        INSERT INTO candidate (name, birth_date, phone, mail)
        VALUES (p_name, p_birth_date, p_phone, p_mail);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE EXCEPTION 'Error adding candidate: %', SQLERRM;
    END;
END;
$$;
```

Эта процедура добавляет нового кандидата в таблицу `candidate` с указанными параметрами (`p_name`, `p_birth_date`, `p_phone`, `p_mail`).

Ключевые моменты:
- Используется блок `BEGIN ... EXCEPTION ... END` для обработки исключений.
- Выполняется оператор `INSERT INTO candidate` для вставки новой записи
# Процедура `add_vacancy_comment(p_vacancy_id INTEGER, p_user_name VARCHAR(45), p_comment VARCHAR(400))`

```sql
CREATE OR REPLACE PROCEDURE add_vacancy_comment(
    p_vacancy_id INTEGER,
    p_user_name VARCHAR(45),
    p_comment VARCHAR(400)
)
    LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO comment (vac_id, user_name, comment, date)
    VALUES (p_vacancy_id, p_user_name, p_comment, CURRENT_DATE);
END;
$$;
```

Эта процедура добавляет новый комментарий к вакансии в таблицу `comment`.

Ключевые моменты:
- Принимает три параметра: `p_vacancy_id` (идентификатор вакансии), `p_user_name` (имя пользователя) и `p_comment` (текст комментария).
- Выполняет оператор `INSERT INTO comment` для вставки новой записи в таблицу `comment`.
- Значения столбцов `vac_id`, `user_name` и `comment` берутся из переданных параметров.
- Значение столбца `date` устанавливается как текущая дата (`CURRENT_DATE`).

# Процедура `update_security_check_status(p_candidate_id INTEGER, p_status VARCHAR(45))`

```sql
CREATE OR REPLACE PROCEDURE update_security_check_status(
    p_candidate_id INTEGER,
    p_status VARCHAR(45)
)
    LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE security_check
    SET status = p_status,
        result_date = CASE WHEN p_status = 'Completed' THEN CURRENT_DATE ELSE NULL END
    WHERE candidate_id = p_candidate_id;
END;
$$;
```

Эта процедура обновляет статус проверки безопасности (`security_check`) для указанного кандидата (`p_candidate_id`) и устанавливает дату результата (`result_date`), если статус изменен на `'Completed'`.

Ключевые моменты:
- Принимает два параметра: `p_candidate_id` (идентификатор кандидата) и `p_status` (новый статус проверки безопасности).
- Выполняет оператор `UPDATE security_check` для обновления записи в таблице `security_check`.
- Устанавливает значение столбца `status` как `p_status`.
- Устанавливает значение столбца `result_date` как текущую дату (`CURRENT_DATE`), если `p_status` равен `'Completed'`, иначе устанавливает `NULL`.
- Условие `WHERE candidate_id = p_candidate_id` определяет запись, которая должна быть обновлена.

Эта процедура может использоваться для отслеживания статуса проверки безопасности для кандидатов и фиксации даты завершения проверки.
# select into zap
```sql
SELECT
    c.name,
    c.birth_date,
    c.phone,
    c.mail
INTO
    candidate_export
FROM
    candidate c;
```

Запрос:
Этот запрос создает новую таблицу `candidate_export` и вставляет в нее выбранные данные из таблицы `candidate`.

Ключевые моменты:
- Используется оператор `SELECT ... INTO` для создания новой таблицы и вставки данных в нее.
- Выбираются столбцы `name`, `birth_date`, `phone` и `mail` из таблицы `candidate`.
- Результаты запроса вставляются в новую таблицу `candidate_export`.
- Структура новой таблицы `candidate_export` определяется автоматически на основе выбранных столбцов.

Вывод:
Запрос создаст новую таблицу `candidate_export` со следующей структурой:

```
candidate_export (
    name VARCHAR(45),
    birth_date DATE,
    phone VARCHAR(400),
    mail VARCHAR(400)
)
```

Таблица `candidate_export` будет содержать все записи из таблицы `candidate`, но только с указанными столбцами: `name`, `birth_date`, `phone` и `mail`.

Этот запрос может использоваться для экспорта данных из таблицы `candidate` в отдельную таблицу, например, для дальнейшего анализа или передачи данных в другую систему.
# trigger
# Функция `update_vacancy_status_trigger()`

```sql
CREATE OR REPLACE FUNCTION update_vacancy_status_trigger()
    RETURNS TRIGGER AS $$
BEGIN
    IF NEW.accept THEN
        UPDATE vacancy SET status = 'Closed' WHERE id = NEW.vacancy_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

Эта функция создается или заменяет существующую функцию триггера `update_vacancy_status_trigger()`. Она выполняет следующие действия:

1. Проверяет, если вновь вставленная запись в таблицу `offer` имеет `accept = true` (предложение принято).
2. Если условие выполнено, обновляет статус соответствующей вакансии в таблице `vacancy` на `'Closed'` (закрытая) по `id` вакансии (`NEW.vacancy_id`).
3. Возвращает новую запись (`RETURN NEW`), что позволяет завершить операцию вставки в таблицу `offer`.

Ключевые моменты:
- Функция написана на языке `plpgsql`.
- Она возвращает тип `TRIGGER`, что означает, что она предназначена для использования в качестве функции триггера.
- Используется условный оператор `IF` для проверки значения `NEW.accept`.
- Выполняется оператор `UPDATE` для изменения статуса вакансии, если предложение было принято.

# Триггер `offer_insert_trigger`

```sql
CREATE TRIGGER offer_insert_trigger
    AFTER INSERT ON offer
    FOR EACH ROW
EXECUTE FUNCTION update_vacancy_status_trigger();
```

Этот запрос создает новый триггер `offer_insert_trigger` на таблице `offer`. Триггер будет срабатывать после вставки новой записи (`AFTER INSERT`) в таблицу `offer` для каждой строки (`FOR EACH ROW`).

При срабатывании триггера будет выполняться функция `update_vacancy_status_trigger()`.

Ключевые моменты:
- Триггер привязан к таблице `offer`.
- Он срабатывает после операции вставки (`AFTER INSERT`).
- Триггер выполняется для каждой вставленной строки (`FOR EACH ROW`).
- При срабатывании триггера выполняется функция `update_vacancy_status_trigger()`.

Таким образом, при каждой вставке новой записи в таблицу `offer` с `accept = true` (принятое предложение), функция `update_vacancy_status_trigger()` обновит статус соответствующей вакансии в таблице `vacancy` на `'Closed'`.

