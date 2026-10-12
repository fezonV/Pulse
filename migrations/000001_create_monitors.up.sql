CREATE TABLE monitors (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    url TEXT NOT NULL UNIQUE,

    next_check_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    check_status VARCHAR(20) NOT NULL DEFAULT 'IDLE'
        CHECK (check_status IN ('IDLE', 'CHECKING')),

    locked_until TIMESTAMPTZ,

    last_result VARCHAR(20)
        CHECK (last_result IN ('UP', 'DOWN', 'UNABLE_TO_CHECK')),

    check_id UUID,

    interval_seconds INTEGER NOT NULL DEFAULT 10
        CHECK (interval_seconds > 0)
);