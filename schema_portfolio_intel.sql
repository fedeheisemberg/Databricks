

## 📄 `schema_portfolio_intel.sql`

```sql
-- =====================================================
-- Portfolio Intelligence Platform
-- Unity Catalog: workspace
-- Schema: portfolio_intel
-- =====================================================

CREATE SCHEMA IF NOT EXISTS workspace.portfolio_intel;

-- =====================================================
-- BRONZE LAYER — Raw, append-only
-- =====================================================

CREATE TABLE IF NOT EXISTS workspace.portfolio_intel.bronze_prices (
    symbol           STRING,
    date             DATE,
    open             DOUBLE,
    high             DOUBLE,
    low              DOUBLE,
    close            DOUBLE,
    adj_close        DOUBLE,
    volume           BIGINT,
    source           STRING,
    ingestion_ts     TIMESTAMP
)
USING DELTA;

CREATE TABLE IF NOT EXISTS workspace.portfolio_intel.bronze_assets (
    symbol          STRING,
    asset_name      STRING,
    asset_type      STRING,   -- ETF | Equity | Commodity | Crypto
    sector          STRING,
    currency        STRING,
    weight_target   DOUBLE,
    is_active       BOOLEAN,
    created_at      TIMESTAMP
)
USING DELTA;

-- =====================================================
-- SILVER LAYER — Clean, deterministic, feature-ready
-- =====================================================

CREATE TABLE IF NOT EXISTS workspace.portfolio_intel.silver_prices_clean (
    symbol          STRING,
    date            DATE,
    price           DOUBLE,
    volume          BIGINT,
    currency        STRING,
    is_trading_day  BOOLEAN,
    cleaned_ts      TIMESTAMP
)
USING DELTA;

CREATE TABLE IF NOT EXISTS workspace.portfolio_intel.silver_returns (
    symbol            STRING,
    date              DATE,
    return_1d         DOUBLE,
    return_5d         DOUBLE,
    rolling_vol_20    DOUBLE,
    drawdown          DOUBLE,
    computed_ts       TIMESTAMP
)
USING DELTA;

CREATE TABLE IF NOT EXISTS workspace.portfolio_intel.silver_features_ml (
    symbol            STRING,
    date              DATE,
    return_1d         DOUBLE,
    return_5d         DOUBLE,
    rolling_mean_20   DOUBLE,
    rolling_vol_20    DOUBLE,
    momentum_10       DOUBLE,
    target_up_1d      INT,
    feature_ts        TIMESTAMP
)
USING DELTA;

-- =====================================================
-- GOLD LAYER — Business-ready, SQL-first
-- =====================================================

CREATE TABLE IF NOT EXISTS workspace.portfolio_intel.gold_portfolio_daily (
    date                  DATE,
    portfolio_value       DOUBLE,
    daily_return          DOUBLE,
    cumulative_return     DOUBLE,
    benchmark_return      DOUBLE,
    created_ts            TIMESTAMP
)
USING DELTA;

CREATE TABLE IF NOT EXISTS workspace.portfolio_intel.gold_risk_metrics (
    metric_name     STRING,
    metric_value    DOUBLE,
    computed_ts     TIMESTAMP
)
USING DELTA;

CREATE TABLE IF NOT EXISTS workspace.portfolio_intel.gold_asset_contribution (
    symbol          STRING,
    date            DATE,
    weight          DOUBLE,
    contribution    DOUBLE,
    created_ts      TIMESTAMP
)
USING DELTA;

CREATE TABLE IF NOT EXISTS workspace.portfolio_intel.gold_return_predictions (
    symbol          STRING,
    date            DATE,
    prob_up         DOUBLE,
    model_version   STRING,
    prediction_ts   TIMESTAMP
)
USING DELTA;
```


