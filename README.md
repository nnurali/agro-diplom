# Ауыл шаруашылығы саласын цифрландыруға арналған мобильді ақпараттық жүйе

Дипломдық жобаның талдау және дерекқор құжаттамасы.

## Жоба құрылымы

* `docs/analysis/` — DFD диаграммалары (`dfd-context`, `dfd-level0`, `dfd-level1`)
* `docs/database/` — ER-диаграмма (`erd`), SQL схемасы (`schema.sql`) және сұраныс нәтижелері (`query-results.png`)

## Деректер ағындары диаграммалары (DFD)

* Контекстік диаграмма (DFD Level 0 / Context): [`docs/analysis/dfd-context.png`](docs/analysis/dfd-context.png)
*  0-деңгейлі диаграмма (DFD Level 0): [`docs/analysis/dfd-level0.png`](docs/analysis/dfd-level0.png)
* 1-деңгейлі диаграмма (DFD Level 1): [`docs/analysis/dfd-level1.png`](docs/analysis/dfd-level1.png)

## Дерекқор құрылымы (ERD және SQL)

* ER-диаграмма: [`docs/database/erd.png`](docs/database/erd.png)
* SQL скрипті (MySQL / XAMPP `agro_system`): [`docs/database/schema.sql`](docs/database/schema.sql)
* Сұраныстар нәтижесі: [`docs/database/query-results.png`](docs/database/query-results.png)


---

## 14-апта: UI дизайн, навигация диаграммасы және экран макеттері (`agro_system`)

**Жоба тақырыбы:** Ауыл шаруашылығы саласын цифрландыруға арналған мобильді ақпараттық жүйе

### Түстер палитрасы
* **Негізгі түс (`#2E7D32`):** Өсімдіктер, егістік алқаптары, негізгі әрекеттер
* **Қосалқы акцент (`#0288D1`):** Суару, ылғалдылық, метеодеректер
* **Ескерту және қате (`#E65100`, `#C62828`):** Ауа райы ескертулері, валидация және `alt` қате хабарламалары

### Навигация және экрандар
* Навигация диаграммасы: [`docs/ui/navigation.drawio`](docs/ui/navigation.drawio) және [`docs/ui/navigation.png`](docs/ui/navigation.png)
* UI есебі мен өзіндік тексеру: [`docs/ui/evaluation.md`](docs/ui/evaluation.md)
* Экран макеттері (`docs/ui/screens/`):
  1. [`01-login.png`](docs/ui/screens/01-login.png) — Кіру экраны (`T1`)
  2. [`02-home.png`](docs/ui/screens/02-home.png) — Басты бет (`T2`, `T6`)
  3. [`03-field-crops.png`](docs/ui/screens/03-field-crops.png) — Егілген дақылдар тізімі (`T3`)
  4. [`04-add-agro-task.png`](docs/ui/screens/04-add-agro-task.png) — Агрошара қосу формасы және қате жағдайы (`T4`, `alt`)
  5. [`05-agro-tasks.png`](docs/ui/screens/05-agro-tasks.png) — Агрошаралар тізімі (`T5`)
  6. [`06-weather-alerts.png`](docs/ui/screens/06-weather-alerts.png) — Ауа райы ескертулері (`T6`)