/*
  БД исторических данных. Хранит все детали, полученные из CMS,
  включая удалённые из CMS (мягкое удаление через is_deleted).
*/
CREATE TABLE IF NOT EXISTS spares_history (
    id             VARCHAR(50) PRIMARY KEY,      /* spareCode */
    name           TEXT        NOT NULL,         /* spareName */
    description    TEXT,                         /* spareDescription */
    type           VARCHAR(50),                  /* spareType */
    status         VARCHAR(50),                  /* spareStatus */
    price          NUMERIC(12, 2),               /* price */
    quantity       INTEGER,                      /* quantity */
    updated_at     TEXT,                         /* updatedAt в исходном формате CMS */
    last_synced_at TIMESTAMPTZ DEFAULT NOW(),    /* когда синхронизация последний раз меняла запись */
    is_deleted     BOOLEAN     DEFAULT FALSE,    /* деталь пропала из CMS */
    deleted_at     TIMESTAMPTZ                   /* когда деталь пропала из CMS */
);

CREATE INDEX IF NOT EXISTS idx_spares_deleted ON spares_history (is_deleted);
