CREATE TABLE checks (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    monitor_id BIGINT NOT NULL
        REFERENCES monitors(id)
        ON DELETE CASCADE,

    checked_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    result VARCHAR(20) NOT NULL
        CHECK (result IN ('UP', 'DOWN', 'UNABLE_TO_CHECK')),

    response_time_ms INTEGER
        CHECK (response_time_ms >= 0),

    http_status_code SMALLINT
        CHECK (http_status_code BETWEEN 100 AND 599)
);

CREATE INDEX idx_checks_monitor_checked_at
ON checks (monitor_id, checked_at DESC);